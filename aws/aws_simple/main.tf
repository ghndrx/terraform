# Define provider
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Define modules
module "vpc_us_west" {
  source = "./modules/vpc"
}

module "subnet_us_west" {
  source = "./modules/subnet"
  vpc_id = module.vpc_us_west.vpc_id
  region = "us-west-2"
}

module "vpc_us_east" {
  source = "./modules/vpc"
  region = "us-east-1"
}

module "subnet_us_east" {
  source = "./modules/subnet"
  vpc_id = module.vpc_us_east.vpc_id
  region = "us-east-1"
}

module "ec2" {
  source = "./modules/ec2"
}

module "elb" {
  source = "./modules/elb"
}

module "efs" {
    source = "./modules/efs"
}
