// Create security group for Application Load Balancer

resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "Load balancer security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

// Allow inbound traffic for ALB

resource "aws_security_group_rule" "alb_inbound" {
  for_each          = var.alb_inb_ports
  type              = "ingress"
  from_port         = each.key
  to_port           = each.key
  protocol          = each.value.protocol
  cidr_blocks       = [each.value.cidr]
  security_group_id = aws_security_group.alb_sg.id
}

// Allow outbound traffic for ALB
resource "aws_security_group_rule" "alb_outbound" {
  for_each          = var.alb_out_ports
  type              = "egress"
  from_port         = each.key
  to_port           = each.key
  protocol          = each.value.protocol
  cidr_blocks       = [each.value.cidr]
  security_group_id = aws_security_group.alb_sg.id
}

// Create security group for EC2

resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-sg"
  description = "EC2 security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.project_name}-ec2-sg"
  }
}

// Allow inbound traffic for EC2

resource "aws_security_group_rule" "ec2_inbound" {
  for_each                 = var.ec2_inb_ports
  type                     = "ingress"
  from_port                = each.key
  to_port                  = each.key
  protocol                 = each.value.protocol
  source_security_group_id = aws_security_group.alb_sg.id
  security_group_id        = aws_security_group.ec2_sg.id
}

// Allow outbound traffic for EC2
resource "aws_security_group_rule" "ec2_outbound" {
  for_each                 = var.ec2_out_ports
  type                     = "egress"
  from_port                = each.key
  to_port                  = each.key
  protocol                 = each.value.protocol
  cidr_blocks              = [each.value.cidr]
  security_group_id        = aws_security_group.ec2_sg.id
}
