# terraform
How to use ALB Microservice


module "private_alb_api" {
  source  = "tfeURL/SkyNet/skynet-application-load-balancer/aws"
  version = "2.0.5"

  resource_name_prefix   = "${var.tenant_code}-AL-PVT-API-INT"
  vpc_id                 = var.al_networking_vpc_id
  subnet_ids             = var.al_networking_private_subnet_ids
  default_tg_port        = var.al_pvt_api_tg_port
  default_tg_healthcheck = var.tg_healthcheck_private
  create_security_group  = false                                      #Inside Microservice Security Group will not be created
  sg_ids                 = [aws_security_group.private_alb_sg.id]     #Pass security Group ID here. 
  create_route53_record  = true                                       #Route53 record will be created
  route53_zone_id        = var.route53_zone_id
  route53_record_name    = "private-api-alb"
  tags                   = var.al_tags
  alb_idle_timeout       = "60"

  region     = var.region
  secret_key = var.secret_key
  access_key = var.access_key
  token      = var.token

}

#create_route53_record = true/false            #true: Route53 will be created. false: Route53 will not be created
#create_security_group  = true/false            #True: It will create default security group, But you have to pass ingress rule. False: You have to pass security group ID.
#alb_is_internal        = true/false            #True: Internal ALB will be created with HTTP Listener , False: External ALB will be created with HTTPS Listener
