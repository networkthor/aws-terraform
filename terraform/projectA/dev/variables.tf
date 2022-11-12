variable "vpc_cidr" {}
variable "project_name" {}
variable "region" {}
variable "public_subnets" {
    type = list(any)
}
variable "private_subnets" {
    type = list(any)
}
variable "alb_inb_ports" {
    type = map(any)
}
variable "alb_out_ports" {
    type = map(any)
}
variable "ec2_inb_ports" {
    type = map(any)
}
variable "ec2_out_ports" {
    type = map(any)
}
variable "domain_name" {}
variable "organization_name" {}
variable "instance_count" {}
variable "instance_type" {}






