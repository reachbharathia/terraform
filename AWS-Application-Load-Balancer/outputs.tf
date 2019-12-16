################
# Target Group #
################
output "target_group_arn" {
  description = "The ARN of the Target Group for the ALB."
  value       = local.tg_arn
}

##################
# Security Group #
##################
output "security_group_ids" {
  description = "The IDs of the Security Groups for the ALB."
  value       = flatten([local.sg_ids])
}

#######
# ALB #
#######
output "alb_arn" {
  description = "ARN of the Application Load Balancer."
  value       = element(concat(aws_lb.this.*.arn, [""]), 0)
}

output "alb_id" {
  description = "ID of the Application Load Balancer."
  value       = element(concat(aws_lb.this.*.id, [""]), 0)
}

output "alb_dns" {
  description = "DNS of the Application Load Balancer."
  value       = element(concat(aws_lb.this.*.dns_name, [""]), 0)
}

output "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer."
  value       = element(concat(aws_lb.this.*.zone_id, [""]), 0)
}

############
# Listener #
############
output "listener_arn" {
  description = "ARN of the Listener."
  value = element(
    concat(
      aws_lb_listener.http_listener.*.arn,
      aws_lb_listener.https_listener.*.arn, [""]
    ),
    0,
  )
}

output "listener_id" {
  description = "ID of the HTTP Listener."
  value = element(
    concat(
      aws_lb_listener.http_listener.*.id,
      aws_lb_listener.https_listener.*.id, [""]
    ),
    0,
  )
}

############
# Route 53 #
############
output "route53_record_name" {
  description = "The Name of the Route 53 Record."
  value       = element(concat(aws_route53_record.this.*.name, [""]), 0)
}

output "route53_record_fqdn" {
  description = "The Fully Qualified Domain Name of the Route 53 Record."
  value       = element(concat(aws_route53_record.this.*.fqdn, [""]), 0)
}

output "alb_name" {
  description = "The Fully Qualified Domain Name of the Route 53 Record."
  value       = element(concat(aws_lb.this.*.name, [""]), 0)
}
