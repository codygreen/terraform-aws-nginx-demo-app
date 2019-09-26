data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name = "name"
    # values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = var.prefix
  instance_count = var.ec2_instance_count

  ami                         = data.aws_ami.latest-ubuntu.id
  associate_public_ip_address = var.associate_public_ip_address
  instance_type               = var.ec2_instance_type
  key_name                    = var.ec2_key_name
  monitoring                  = true
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_ids                  = var.vpc_subnet_ids

  user_data = templatefile("${path.module}/userdata.tmpl", {})

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Application = var.prefix
  }
}
