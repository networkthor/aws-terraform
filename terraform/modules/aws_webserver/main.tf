// AMI for EC2

data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_availability_zones" "available" {}

// Create SSH key pair

resource "aws_key_pair" "auth" {
  key_name   = "webserver-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

// Create EC2

resource "aws_instance" "webserver" {
  count                  = var.instance_count
  instance_type          = var.instance_type
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.auth.id
  vpc_security_group_ids = [var.ec2_sg_id]
  subnet_id              = var.public_subnets_id


  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = "${var.project_name}-node-${count.index + 1}"
  }
}

// Attach instances to ALB target group

resource "aws_alb_target_group_attachment" "alb_tg_attach" {
  count            = length(aws_instance.webserver)
  target_group_arn = var.alb_target_group_arn
  target_id        = element(aws_instance.webserver[*].id, count.index)
  port             = 80
}

