output "default_alb_example_target_group_arn" {
  description = "The ARN of the Target Group for the ALB."
  value       = module.default_alb_example.target_group_arn
}

output "default_alb_example_security_group_ids" {
  description = "The IDs of the Security Groups for the ALB."
  value       = module.default_alb_example.security_group_ids
}

output "default_alb_example_alb_arn" {
  description = "ARN of the Application Load Balancer."
  value       = module.default_alb_example.alb_arn
}

output "default_alb_example_alb_id" {
  description = "ID of the Application Load Balancer."
  value       = module.default_alb_example.alb_id
}

output "default_alb_example_alb_dns" {
  description = "DNS of the Application Load Balancer."
  value       = module.default_alb_example.alb_dns
}

output "default_alb_example_alb_zone_id" {
  description = "Zone ID of the Application Load Balancer."
  value       = module.default_alb_example.alb_zone_id
}

output "default_alb_example_listener_arn" {
  description = "ARN of the Listener."
  value       = module.default_alb_example.listener_arn
}

output "default_alb_example_listener_id" {
  description = "ID of the HTTP Listener."
  value       = module.default_alb_example.listener_id
}

output "default_alb_example_route53_record_name" {
  description = "The Name of the Route 53 Record."
  value       = module.default_alb_example.route53_record_name
}

output "default_alb_example_route53_record_fqdn" {
  description = "The Fully Qualified Domain Name of the Route 53 Record."
  value       = module.default_alb_example.route53_record_fqdn
}

output "default_alb_example_resource_name_prefix" {
  description = "Name of ALB"
  value       = module.default_alb_example.alb_name
}
