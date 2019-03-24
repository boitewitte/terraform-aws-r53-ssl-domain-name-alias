locals {
  domain_names = "${concat(list(var.domain_name), var.alternative_names)}"

  enabled = "${var.enabled == "true" && var.domain_name != "" && var.zone_name != "" ? true : false}"
}

data "aws_route53_zone" "zone" {
  count        = "${local.enabled == "true" ? 1 : 0 }"

  name         = "${var.zone_name}"
  private_zone = "${var.zone_private}"
}

module "label" {
  source = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.6.0"

  enabled = "${local.enabled}"

  name        = "${var.domain_name}"
  namespace   = "${var.namespace}"
  environment = "${var.environment}"
  stage       = "${var.stage}"
  delimiter   = "${var.delimiter}"
  attributes  = ["${var.attributes}"]
  tags        = "${var.tags}"

  context = "${var.context}"
}

resource "aws_acm_certificate" "cert" {
  count = "${local.enabled == "true" ? 1 : 0}"

  domain_name               = "${var.domain_name}"
  subject_alternative_names = ["${var.alternative_names}"]

  validation_method = "DNS"

  tags = "${module.label.tags}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  count = "${local.enabled == "true" ? length(aws_acm_certificate.cert.*.domain_validation_options) : 0}"

  zone_id = "${data.aws_route53_zone.zone.id}"

  name    = "${element(aws_acm_certificate.cert.domain_validation_options.*.resource_record_name, count.index)}"
  type    = "${element(aws_acm_certificate.cert.domain_validation_options.*.resource_record_type, count.index)}"
  records = ["${element(aws_acm_certificate.cert.domain_validation_options.*.resource_record_value, count.index)}"]

  # tags = "${module.label.tags}"

  ttl = 60
}

resource "aws_acm_certificate_validation" "cert" {
  count = "${local.enabled == "true" ? length(aws_acm_certificate.cert.domain_validation_options) : 0}"

  certificate_arn = "${aws_acm_certificate.cert.arn}"

  validation_record_fqdns = ["${element(aws_route53_record.cert_validation.*.fqdn, count.index)}"]
}

resource "aws_route53_record" "service" {
  count = "${local.enabled == "true" ? length(local.domain_names) : 0}"

  zone_id = "${data.aws_route53_zone.zone.zone_id}"
  name    = "${element(local.domain_names, count.index)}"
  type    = "A"

  alias {
    name                   = "${var.alias_dns_name}"
    zone_id                = "${var.alias_zone_id}"
    evaluate_target_health = "${var.alias_evaluate_target_health}"
  }

  # tags = "${module.label.tags}"
}
