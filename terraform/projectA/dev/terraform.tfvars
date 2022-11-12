project_name    = "projectA-dev"
region          = "eu-central-1"
vpc_cidr = "10.111.0.0/16"
public_subnets  = ["10.111.1.0/24", "10.111.2.0/24"]
private_subnets = ["10.111.101.0/24", "10.111.102.0/24"]
alb_inb_ports = {
  80 = {
    protocol = "TCP"
    cidr     = "0.0.0.0/0"
  },
  443 = {
    protocol = "TCP"
    cidr     = "0.0.0.0/0"
  }
}

alb_out_ports = {
  0 = {
    protocol = "-1"
    cidr     = "0.0.0.0/0"
  }
}

ec2_inb_ports = {
  22 = {
    protocol = "TCP"
    cidr     = "46.34.192.56/32"
  },
  80 = {
    protocol = "TCP"
    cidr     = "0.0.0.0/0"
  }
}

ec2_out_ports = {
  0 = {
    protocol = "-1"
    cidr     = "0.0.0.0/0"
  }
}

domain_name = "dev.networkthor.com"
organization_name = "NetworkThor, Inc"
instance_count = "2"
instance_type  = "t2.micro"

