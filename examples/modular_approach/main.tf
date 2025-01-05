terraform {
  required_providers {
    aws = {
      source = "hasicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "network" {
  source                   = "./modules/network"
  vpc_cidr_block           = "10.0.0.0/16"
  public_subnet_cidr_block = "10.0.1.0/24"
  private_subnet_cidr_block = "10.0.2.0/24"
  availability_zone        = var.aviability_zone
}

module "security_group" {
  source                   = "./modules/security_group"
  vpc_id                   = module.network.vpc_id
  public_subnet_cidr_block = module.network.public_subnet_id
  private_subnet_cidr_block = module.network.private_subnet_id
}

module "instance" {
  source          = "./modules/instance"
  ami_id          = "ami-0c55b159cbfafe1f0"  # Replace with your desired AMI ID
  instance_type  = var.instance_type
  public_subnet_id = module.network.public_subnet_id
  private_subnet_id = module.network.private_subnet_id
  security_groups = [module.security_group.public_sg_id, module.security_group.private_sg_id]
}

output "public_instance_ip" {
  value = module.instance.public_instance_ip
}

output "private_instance_ip" {
  value = module.instance.private_instance_ip
}
