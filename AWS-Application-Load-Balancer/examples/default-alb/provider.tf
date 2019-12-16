####################
# Default Provider #
####################
variable "region" {
}

variable "access_key" {
}

variable "secret_key" {
}

variable "token" {
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.token
  region     = var.region
}

#####################
# Route 53 Provider #
#####################
variable "route53_region" {
}

variable "route53_access_key" {
}

variable "route53_secret_key" {
}

variable "route53_token" {
}

provider "aws" {
  alias      = "route53"
  access_key = var.route53_access_key
  secret_key = var.route53_secret_key
  token      = var.route53_token
  region     = var.route53_region
}

