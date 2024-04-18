resource "aws_lb" "myalb" {
  load_balancer_type = var.my_alb.lbtype
  subnets            = [aws_subnet.mysubnet1.id, aws_subnet.mysubnet2.id]
  security_groups = [aws_security_group.mysg.id]

  tags = {
    Name = var.my_alb.name
  }
}

resource "aws_lb_listener" "myhttp" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = var.my_http.port
  protocol          = var.my_http.protocol

  # By default, return a simple 404 page
  default_action {
    type = var.my_http.da_type

    fixed_response {
      content_type = var.my_http.fr_ct_type
      message_body = var.my_http.fr_ct_mb
      status_code  = var.my_http.fr_ct_sc
    }
  }
}

resource "aws_lb_target_group" "myalbtg" {
  name = var.my_alb_tg.name
  port     = var.my_alb_tg.port
  protocol = var.my_alb_tg.protocol
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path                = var.my_alb_tg.hc_path
    protocol            = var.my_alb_tg.hc_protocol
    matcher             = var.my_alb_tg.hc_matcher
    interval            = var.my_alb_tg.hc_interval
    timeout             = var.my_alb_tg.hc_timeout
    healthy_threshold   = var.my_alb_tg.hc_ht
    unhealthy_threshold = var.my_alb_tg.hc_ut
  }
}

resource "aws_lb_listener_rule" "myalbrule" {
  listener_arn = aws_lb_listener.myhttp.arn
  priority     = var.my_alb_rule.priority

  condition {
    path_pattern {
      values = var.my_alb_rule.con_pp_values
    }
  }

  action {
    type             = var.my_alb_rule.act_type
    target_group_arn = aws_lb_target_group.myalbtg.arn
  }
}

output "myalb_dns" {
  value       = aws_lb.myalb.dns_name
  description = "The DNS Address of the ALB"
}
