##########
# Common #
##########
variable "execute_microservice" {
  description = "Main switch to control the execution of this microservice based on consumer logic."
  default     = true
}

variable "create_security_group" {
  description = "If you have security group and dont want to create inside then make it false"
  default     = true
}

variable "resource_name_prefix" {
  description = "Name prefix to be used to derive names for all the resources."
}

variable "vpc_id" {
  description = "The VPC id to be used for default TG and default SG creation."
  default     = ""
}

################
# Target Group #
################
variable "tg_arn" {
  description = "ARN of the Target Group for the listner. One will be created if empty."
  default     = ""
}

variable "default_tg_target_type" {
  description = "The target type indicates whether targets are registered using instance IDs or private IP addresses."
  default     = "instance"
}

variable "default_tg_protocol" {
  description = "The protocol the load balancer uses when routing traffic to targets in the default target group."
  default     = "HTTP"
}

variable "default_tg_port" {
  description = "The port the load balancer uses when routing traffic to targets in the default target group."
  default     = "80"
}

variable "default_tg_stickiness" {
  description = "The settings to be used for default target group stickiness."
  default = [
    {
      enabled         = false
      type            = "lb_cookie"
      cookie_duration = 86400
    },
  ]
}

variable "default_tg_healthcheck" {
  description = "The settings to be used for default target group health check."
  default = [
    {
      enabled             = true
      interval            = 60
      path                = "/"
      protocol            = "HTTP"
      port                = 80
      healthy_threshold   = 3
      unhealthy_threshold = 3
      timeout             = 5
    },
  ]
}

#################
# Secutiy Group #
#################
variable "sg_ids" {
  description = "List of IDs of the Security Groups for the ALB. One will be created if empty."
  default     = []
}

variable "default_sg_ingress_rules" {
  description = "List of Ingress Rules for the default Security Group."
  type        = any
  default     = []
}

variable "default_sg_egress_rules" {
  description = "List of Egress Rules for the default Security Group."
  type        = any
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}

#######
# ALB #
#######
variable "alb_is_internal" {
  description = "Controls if ALB should be created as Internal or Internet facing."
  default     = "true"
}

variable "subnet_ids" {
  description = "A list of Subnet IDs to attach to the ALB. Private Subnets for Internal or Public Subnets for Internet facing."
  default     = []
}

variable "alb_idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  default     = "60"
}

variable "alb_enable_deletion_protection" {
  description = "Enable deletion protection for ALB."
  default     = "false"
}

variable "alb_enable_http2" {
  description = "Indicates whether HTTP/2 is enabled in application load balancers."
  default     = "true"
}

variable "alb_ip_address_type" {
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack."
  default     = "ipv4"
}

variable "alb_access_log_bucket" {
  description = "Bucket for storing access log for ALB."
  default     = "skynet-tenant-accesslogs"
}

variable "alb_enable_access_log" {
  description = "Enable access log for ALB."
  default     = "false"
}

#################
# HTTP Listener #
#################
variable "http_listener_protocol" {
  description = "ALB HTTP listerner protocol."
  default     = "HTTP"
}

variable "http_listener_port" {
  description = "ALB HTTP listerner port."
  default     = "80"
}

variable "http_listener_default_action_type" {
  description = "ALB HTTP listerner default action."
  default     = "forward"
}

##################
# HTTPS Listener #
##################
variable "https_listener_protocol" {
  description = "ALB HTTPS listener protocol."
  default     = "HTTPS"
}

variable "https_listener_port" {
  description = "ALB HTTPS listener port."
  default     = "443"
}

variable "https_listener_ssl_policy" {
  description = "ALB HTTPS listener SSL policy name."
  default     = ""
}

variable "https_listener_certificate_arn" {
  description = "ALB HTTPS listener SSL certificate ARN."
  default     = ""
}

variable "https_listener_default_action_type" {
  description = "HTTP listerner default action."
  default     = "forward"
}

############
# Route 53 #
############
variable "create_route53_record" {
  description = "Controls if Route 53 record should be created."
  default     = true
}

variable "route53_record_type" {
  description = "The type of the Route 53 record."
  default     = "CNAME"
}

variable "route53_record_ttl" {
  description = "The TTL of the Route 53 record."
  default     = "3600"
}

variable "route53_zone_id" {
  description = "The ID of the Hosted zone for the Route 53 record."
  default     = ""
}

variable "route53_record_name" {
  description = "The Name of the Route 53 record."
  default     = ""
}

variable "route53_record_allow_overwrite" {
  description = "Controls if Route 53 record should be overwritten if already exists."
  default     = true
}

########
# Tags #
########
variable "tags" {
  description = "A map of tags to add to all resources."
  default     = {}
}

variable "default_tg_tags" {
  description = "Additional tags for the Target Group."
  default     = {}
}

variable "default_sg_tags" {
  description = "Additional tags for the Security Group."
  default     = {}
}

variable "alb_tags" {
  description = "Additional tags for the Application Load Balancer."
  default     = {}
}

