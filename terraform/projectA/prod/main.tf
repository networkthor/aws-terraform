terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region                   = var.region
}

terraform {
  backend "s3" {
    bucket = "networkthor-terraform-aws"
    key = "projectA/prod/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "vpc" {
  source = "../../modules/aws_vpc"
  vpc_cidr        = var.vpc_cidr
  project_name    = var.project_name
  region          = var.region
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "security_group" {
  source = "../../modules/aws_sg"
  vpc_id = module.vpc.vpc_id
  project_name  = var.project_name
  alb_inb_ports = var.alb_inb_ports
  alb_out_ports = var.alb_out_ports
  ec2_inb_ports = var.ec2_inb_ports
  ec2_out_ports = var.ec2_out_ports
}

module "acm" {
  source = "../../modules/aws_acm"
  domain_name = var.domain_name
  organization_name = var.organization_name
}

module "alb" {
  source = "../../modules/aws_alb"
  project_name = var.project_name
  alb_sg_id = module.security_group.alb_sg_id
  public_subnets = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_id
  certificate_arn = module.acm.certificate_arn
}

module "webserver" {
  source = "../../modules/aws_webserver"
  project_name = var.project_name
  instance_count = var.instance_count
  instance_type = var.instance_type
  ec2_sg_id  = module.security_group.ec2_sg_id
  public_subnets_id = module.vpc.public_subnets[0].id
  alb_target_group_arn = module.alb.alb_target_group_arn
}

// Generate inventory file for Ansible

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tpl",
    {
      web-srv = module.webserver.webserver_public_ip
    }
  )
  filename = "ansible/inventory"
}