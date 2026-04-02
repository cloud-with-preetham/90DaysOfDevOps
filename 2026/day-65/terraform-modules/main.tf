locals {
  common_tags = {
    Project = "Terraform Modules"
    Owner   = "Preetham"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "terraweek-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway   = false
  enable_dns_hostnames = true

  map_public_ip_on_launch = true

  tags = local.common_tags
}

module "web_sg" {
  source = "./modules/security-group"

  sg_name       = "terraweek-web-sg"
  vpc_id        = module.vpc.vpc_id
  ingress_ports = [80, 443]

  tags = local.common_tags
}

module "web_server" {
  source             = "./modules/ec2-instance"
  ami_id             = data.aws_ami.amazon_linux.id
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraweek-web-server"
  tags               = local.common_tags
}

module "api_server" {
  source             = "./modules/ec2-instance"
  ami_id             = data.aws_ami.amazon_linux.id
  subnet_id          = module.vpc.private_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "terraweek-api-server"
  tags               = local.common_tags
}
