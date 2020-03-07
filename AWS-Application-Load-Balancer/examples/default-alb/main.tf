module "default_alb_example" {
  source = "../../"

  resource_name_prefix  = var.resource_name_prefix
  vpc_id                = var.vpc_id
  subnet_ids            = var.subnet_ids
  route53_zone_id       = var.route53_zone_id
  route53_record_name   = var.route53_record_name
  tags                  = var.tags

  create_route53_record = var.create_route53_record
  create_security_group = var.create_security_group
  alb_is_internal       = var.alb_is_internal

  access_key            = var.access_key
  secret_key            = var.secret_key
  token                 = var.token
  region                = var.region

  route53_region        = var.route53_region
  route53_secret_key    = var.route53_secret_key
  route53_access_key    = var.route53_access_key
  route53_token         = var.route53_token
}

