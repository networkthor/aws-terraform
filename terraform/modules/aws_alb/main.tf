// Create Application Load Balancer

resource "aws_alb" "alb" {
  name            = "${var.project_name}-alb"
  security_groups = [var.alb_sg_id]
  subnets         = [for subnet in var.public_subnets : subnet.id]
  tags = {
    Name = "${var.project_name}-alb"
  }
}

// Create target group for ALB

resource "aws_alb_target_group" "alb_tg" {
  name     = "${var.project_name}-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  stickiness {
    type = "lb_cookie"
  }
}

// Create http/https listener for Application Load Balancer

resource "aws_alb_listener" "http_listeners" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "https_listeners" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn
  default_action {
    target_group_arn = aws_alb_target_group.alb_tg.arn
    type             = "forward"
  }
}
