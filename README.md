# terraform-aws-r53-ssl-domain-name-alias
Terraform module that creates a ACM certificate and Route53 records with an alias

## Usage

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional_tag_map | Additional tags for appending to each tag map | map | `<map>` | no |
| attributes | Additional attributes (e.g. `1`) | list | `<list>` | no |
| context | Default context to use for passing state between label invocations | map | `<map>` | no |
| delimiter | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes` | string | `-` | no |
| enabled | Set to false to prevent the module from creating any resources | string | `true` | no |
| environment | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | string | `` | no |
| label_order | The naming order of the id output and Name tag | list | `<list>` | no |
| name | Solution name, e.g. 'app' or 'jenkins' | string | `` | no |
| namespace | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | string | `` | no |
| stage | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | string | `` | no |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')` | map | `<map>` | no |
| alias_dns_name | DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone. | string | - | yes |
| alias_zone_id | Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone. | string |  - | yes
| alias_evaluate_target_health | Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set. | string | `true` | no |
| alternative_names | "A list of domains that should be SANs in the issued certificate. | <list> | no |
| domain_name | The main domain name | string | - | yes |
| zone_name | The Hosted Zone name of the desired Hosted Zone | string | - | yes |
| zone_private | Set to true when Hosted Zone is a Private hosted zone | string | `false` | no |
