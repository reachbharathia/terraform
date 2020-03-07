
#Providers
region              = "<insert region here>"
access_key          = "<insert access_key here>"
secret_key          = "<insert secret_key here>"
token               = "<insert token here>"



#ALB
create_route53_record = true/false            #true: Route53 will be created. false: Route53 will not be created
route53_zone_id       = "Route53_Zone_ID"
route53_record_name   = "Rounte53_Record_Name"

resource_name_prefix  = "<Resource Name>"     #Resource Name
vpc_id                = "<VPC_ID>"

create_security_group = true/false            #True: It will create default security group, But you have to pass ingress rule. False: You have to pass security group ID.

alb_is_internal       = true/false            #True: Internal ALB will be created with HTTP Listener , False: External ALB will be created with HTTPS Listener

subnet_ids            = ["Subnet_ID_1", "Subnet_ID_2"]

tags                  = {"TenantCode" = "Client Name", "UserName" = "<User Name>"}