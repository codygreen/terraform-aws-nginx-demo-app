provider "aws" {
  region = local.region
}

# Variable for the EC2 Key 
# Set via CLI or via terraform.tfvars file
variable "ec2_key_name" {
  description = "AWS EC2 Key name for SSH access"
  type        = string
}

#
# Create a random id
#
resource "random_id" "id" {
  byte_length = 2
}

#
# Create the VPC
#
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = format("%s-vpc-%s", local.prefix, random_id.id.hex)
  cidr                 = local.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  azs = local.azs

  public_subnets = [
    for num in range(length(local.azs)) :
    cidrsubnet(local.cidr, 8, num)
  ]

  tags = {
    Name        = format("%s-vpc-%s", local.prefix, random_id.id.hex)
    Terraform   = "true"
    Environment = "dev"
  }
}

#
# Create a security group for port 80 traffic
#
module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = format("%s-web-server-%s", local.prefix, random_id.id.hex)
  description = "Security group for web-server with HTTP ports"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [local.cidr, local.allowed_app_cidr]
}

#
# Create a security group for port 80 traffic
#
module "ssh_secure_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = format("%s-ssh-%s", local.prefix, random_id.id.hex)
  description = "Security group for SSH ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [local.cidr, local.allowed_mgmt_cidr]
}

#
# Create NGINX Instance
#
module aws-nginx-demo {
  source = "../"

  prefix = format(
    "%s-%s",
    local.prefix,
    random_id.id.hex
  )
  associate_public_ip_address = true
  ec2_key_name                = var.ec2_key_name
  vpc_security_group_ids = [
    module.web_server_sg.this_security_group_id,
    module.ssh_secure_sg.this_security_group_id
  ]
  vpc_subnet_ids     = module.vpc.public_subnets
  ec2_instance_count = 4
}

locals {
  prefix            = "tf-aws-nginx-demo-app"
  region            = "us-east-2"
  azs               = ["us-east-2a", "us-east-2b"]
  cidr              = "10.0.0.0/16"
  allowed_app_cidr  = "0.0.0.0/0"
  allowed_mgmt_cidr = "0.0.0.0/0"
}
