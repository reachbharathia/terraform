module "default_alb_example" {
  source = "../../"

  resource_name_prefix = var.default_alb_example_resource_name_prefix
  vpc_id               = var.default_alb_example_vpc_id
  subnet_ids           = var.default_alb_example_subnet_ids
  route53_zone_id      = var.default_alb_example_route53_zone_id
  route53_record_name  = var.default_alb_example_route53_record_name
  tags                 = var.default_alb_example_tags

  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.token
  region     = var.region

  route53_region     = var.route53_region
  route53_secret_key = var.route53_secret_key
  route53_access_key = var.route53_access_key
  route53_token      = var.route53_token
}

