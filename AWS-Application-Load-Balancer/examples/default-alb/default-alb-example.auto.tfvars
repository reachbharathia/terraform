#############
# Providers #
#############
####################
# Default Provider #
####################
region              = "<insert region here>"
access_key          = "<insert access_key here>"
secret_key          = "<insert secret_key here>"
token               = "<insert token here>"

#####################
# Route 53 Provider #
#####################
route53_region      = "<insert route53 region here>"
route53_access_key  = "<insert route53 access_key here>"
route53_secret_key  = "<insert route53 secret_key here>"
route53_token       = "<insert route53 token here>"

#######
# ALB #
#######
default_alb_example_resource_name_prefix = "<Resource Name>"
default_alb_example_vpc_id               = "<VPC_ID>"

#If are you usins external ALB then pass pUblic subnets else use private one
default_alb_example_subnet_ids           = ["Subnet_ID_1", "Subnet_ID_2"]
default_alb_example_route53_zone_id      = "Route53_Zone_ID"
default_alb_example_route53_record_name  = "Rounte53_Record_Name"
default_alb_example_tags                 = {"TenantCode" = "001", "UserName" = "<User Name>"}