variable "namespace" {
  type        = "string"
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation"
}

variable "environment" {
  type        = "string"
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "stage" {
  type        = "string"
  default     = ""
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
}

variable "enabled" {
  type        = "string"
  default     = "true"
  description = "Set to false to prevent the module from creating any resources"
}

variable "delimiter" {
  type        = "string"
  default     = "-"
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = "list"
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "additional_tag_map" {
  type        = "map"
  default     = {}
  description = "Additional tags for appending to each tag map"
}

variable "context" {
  type        = "map"
  default     = {}
  description = "Default context to use for passing state between label invocations"
}

variable "alias_dns_name" {
  type        = "string"
  description = "DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone."
}

variable "alias_zone_id" {
  type        = "string"
  description = "Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone."
}

variable "alias_evaluate_target_health" {
  description = "Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set."
  default     = true
}

variable "alternative_names" {
  type        = "list"
  description = "A list of domains that should be SANs in the issued certificate."
  default     = []
}

variable "domain_name" {
  type        = "string"
  description = "Domain name"
}

variable "zone_name" {
  type        = "string"
  description = "The Hosted Zone name of the desired Hosted Zone."
}

variable "zone_private" {
  type        = "string"
  description = "false"
}
