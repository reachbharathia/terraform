locals {
  tg_arn = element(coalescelist(aws_lb_target_group.this.*.arn, [var.tg_arn]),0,)
  sg_ids = split(",",var.create_security_group ? join(",", aws_security_group.this.*.id) : join(",", var.sg_ids),)
       }

################
# Target Group #
################
resource "aws_lb_target_group" "this" {
  count = var.execute_microservice && var.tg_arn == "" ? 1 : 0

  name        = format("%s-%s", var.resource_name_prefix, "TG")
  vpc_id      = var.vpc_id
  protocol    = var.default_tg_protocol
  port        = var.default_tg_port
  target_type = var.default_tg_target_type
  dynamic "stickiness" {
    for_each = var.default_tg_stickiness
    content {
     cookie_duration = lookup(stickiness.value, "cookie_duration", null)
     enabled         = lookup(stickiness.value, "enabled", null)
     type            = stickiness.value.type
    }
  }
  dynamic "health_check" {
    for_each = var.default_tg_healthcheck
    content {
      enabled             = lookup(health_check.value, "enabled", null)
      healthy_threshold   = lookup(health_check.value, "healthy_threshold", null)
      interval            = lookup(health_check.value, "interval", null)
      matcher             = lookup(health_check.value, "matcher", null)
      path                = lookup(health_check.value, "path", null)
      port                = lookup(health_check.value, "port", null)
      protocol            = lookup(health_check.value, "protocol", null)
      timeout             = lookup(health_check.value, "timeout", null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
    }
  }
  tags = merge({"Name" = format("%s-%s", var.resource_name_prefix, "TG")},var.tags,var.default_tg_tags,)
}

#################
# Secuity Group #
#################
resource "aws_security_group" "this" {
  count = var.execute_microservice && var.create_security_group ? 1 : 0

  name = format("%s-%s", var.resource_name_prefix, "ALB-SG")
  description = format("Auto-generated Security Group for %s-%s",var.resource_name_prefix,"ALB",)
  vpc_id = var.vpc_id
  dynamic "ingress" {
    for_each = var.default_sg_ingress_rules
    content {
      cidr_blocks      = lookup(ingress.value, "cidr_blocks", null)
      description      = lookup(ingress.value, "description", null)
      from_port        = lookup(ingress.value, "from_port", null)
      ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks", null)
      prefix_list_ids  = lookup(ingress.value, "prefix_list_ids", null)
      protocol         = lookup(ingress.value, "protocol", null)
      security_groups  = lookup(ingress.value, "security_groups", null)
      self             = lookup(ingress.value, "self", null)
      to_port          = lookup(ingress.value, "to_port", null)
    }
  }
  dynamic "egress" {
    for_each = var.default_sg_egress_rules
    content {
      cidr_blocks      = lookup(egress.value, "cidr_blocks", null)
      description      = lookup(egress.value, "description", null)
      from_port        = lookup(egress.value, "from_port", null)
      ipv6_cidr_blocks = lookup(egress.value, "ipv6_cidr_blocks", null)
      prefix_list_ids  = lookup(egress.value, "prefix_list_ids", null)
      protocol         = lookup(egress.value, "protocol", null)
      security_groups  = lookup(egress.value, "security_groups", null)
      self             = lookup(egress.value, "self", null)
      to_port          = lookup(egress.value, "to_port", null)
    }
  }
  tags = merge({"Name" = format("%s-%s", var.resource_name_prefix, "ALB-SG")},var.tags,var.default_sg_tags,)
}

#######
# ALB #
#######
resource "aws_lb" "this" {
  count = var.execute_microservice ? 1 : 0

  name                       = format("%s-%s", var.resource_name_prefix, "ALB")
  internal                   = var.alb_is_internal
  load_balancer_type         = "application"
  security_groups            = flatten([local.sg_ids])
  subnets                    = flatten(var.subnet_ids)
  idle_timeout               = var.alb_idle_timeout
  enable_deletion_protection = var.alb_enable_deletion_protection
  enable_http2               = var.alb_enable_http2
  ip_address_type            = var.alb_ip_address_type
  access_logs {
    bucket  = var.alb_access_log_bucket
    enabled = var.alb_enable_access_log
  }
  tags                       = merge({"Name" = format("%s-%s", var.resource_name_prefix, "ALB")},var.tags,var.alb_tags,)
}

#################
# HTTP Listener #
#################
resource "aws_lb_listener" "http_listener" {
  count = var.execute_microservice && var.alb_is_internal ? 1 : 0

  load_balancer_arn = element(concat(aws_lb.this.*.arn, [""]), 0)
  port              = var.http_listener_port
  protocol          = var.http_listener_protocol
  default_action {
    type             = var.http_listener_default_action_type
    target_group_arn = local.tg_arn
  }
}

##################
# HTTPS Listener #
##################
resource "aws_lb_listener" "https_listener" {
  count = var.execute_microservice && var.alb_is_internal ? 0 : 1

  load_balancer_arn = aws_lb.this[0].arn
  port              = var.https_listener_port
  protocol          = var.https_listener_protocol
  ssl_policy        = var.https_listener_ssl_policy
  certificate_arn   = var.https_listener_certificate_arn
  default_action {
    type             = var.https_listener_default_action_type
    target_group_arn = local.tg_arn
  }
}

###################
# Route 53 Record #
###################
resource "aws_route53_record" "this" {
  provider = aws.route53

  count = var.execute_microservice && var.create_route53_record ? 1 : 0

  zone_id         = var.route53_zone_id
  name            = var.route53_record_name
  type            = var.route53_record_type
  ttl             = var.route53_record_ttl
  allow_overwrite = var.route53_record_allow_overwrite
  records         = aws_lb.this.*.dns_name
}

