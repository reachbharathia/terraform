variable "resource_name_prefix" {
}

variable "vpc_id" {
}

variable "subnet_ids" {
  type = any
}

variable "route53_zone_id" {
}

variable "route53_record_name" {
}

variable "tags" {
  type = any
}

variable "create_route53_record" {
}

variable "create_security_group" {
}

variable "alb_is_internal" {
}

