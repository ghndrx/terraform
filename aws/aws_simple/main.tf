# Define provider
provider "aws" {
  region     = var.aws_region
}

# Define modules
module "vpc_us" {
  source = "./modules/vpc"

  us_east_subnet_1_id = module.subnets_us_east.us_east_subnet_1_id
  us_east_subnet_2_id = module.subnets_us_east.us_east_subnet_2_id
  us_east_subnet_3_id = module.subnets_us_east.us_east_subnet_3_id

  us_west_subnet_1_id = module.subnets_us_west.us_west_subnet_1_id
  us_west_subnet_2_id = module.subnets_us_west.us_west_subnet_2_id
  us_west_subnet_3_id = module.subnets_us_west.us_west_subnet_3_id
}

module "subnets_us_west" {
  source = "./modules/vpc/subnets/us-west"
  vpc_id = module.vpc_us.vpc_id
}

module "subnets_us_east" {
  source = "./modules/vpc/subnets/us-east"
  vpc_id = module.vpc_us.vpc_id
}

module "ec2" {
  source = "./modules/ec2"
  
  us_east_subnet_1_id = module.subnets_us_east.us_east_subnet_1_id
  us_east_subnet_2_id = module.subnets_us_east.us_east_subnet_2_id
  us_east_subnet_3_id = module.subnets_us_east.us_east_subnet_3_id

  us_west_subnet_1_id = module.subnets_us_west.us_west_subnet_1_id
  us_west_subnet_2_id = module.subnets_us_west.us_west_subnet_2_id
  us_west_subnet_3_id = module.subnets_us_west.us_west_subnet_3_id

  vpc_id = module.vpc_us.vpc_id
}

module "elb" {
  source = "./modules/elb"
}

module "efs" {
    source = "./modules/efs"
}
