# AWS ALB Terraform microservice

Terraform module which creates ALB resources on AWS.

These types of resources are supported:

* [ALB](https://www.terraform.io/docs/providers/aws/r/lb.html)
* [Target Group](https://www.terraform.io/docs/providers/aws/r/lb_target_group.html)
* [Security Group](https://www.terraform.io/docs/providers/aws/r/security_group.html)
* [HTTP/HTTPS Listener](https://www.terraform.io/docs/providers/aws/r/lb_listener_rule.html)
* [Route53 Record](https://www.terraform.io/docs/providers/aws/r/route53_record.html)



## Terraform versions Required

Terraform 0.12.X

## Usage

```hcl
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
```

## ALB Microservice Scenarios

This module supports three scenarios for creating ALB with multiple options. Each will be explained in further detail in the corresponding sections.

* create_route53_record (true/false)
    * `true  = Route53 record will be created`
    * `false = Route 53 record will not be created `

* create_security_group (true/false)
    * `true  = It will create default security group, But you have to pass ingress rules`
    * `false = Microservice will not create the SG, You have to pass security group ID`
	
* alb_is_internal (true/false)
    * `true  = Internal ALB will be created with HTTP Listener`
    * `false = External ALB will be created with HTTPS Listener`

## Default values
```hcl
`create_security_group` default set to `true` , So you have to pass ingress rules.
`create_route53_record` default set to `false`.
`alb_is_internal`       default set to `true` Internal ALB will be created by default.
```

## Author

Module is maintained by [Bharathi Anbazhagan](https://github.com/reachbharathia) 

## ALB Microservice Version
```hcl

v1.0.0 - Initial Release 

```




