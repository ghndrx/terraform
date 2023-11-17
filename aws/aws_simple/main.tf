# Define provider
provider "aws" {
  region     = var.aws_region
}

# Define modules
module "vpc-east" {
  source = "./modules/vpc/vpc-east"
  region = "us-east-1"
  us_east_subnet_1_id = module.subnets_us_east.us_east_subnet_1_id
  us_east_subnet_2_id = module.subnets_us_east.us_east_subnet_2_id
  us_east_subnet_3_id = module.subnets_us_east.us_east_subnet_3_id
}

module "vpc-west" {
  source = "./modules/vpc/vpc-west"
  region = "us-west-2"
  us_west_subnet_1_id = module.subnets_us_west.us_west_subnet_1_id
  us_west_subnet_2_id = module.subnets_us_west.us_west_subnet_2_id
  us_west_subnet_3_id = module.subnets_us_west.us_west_subnet_3_id
}

module "subnets_us_west" {
  source = "./modules/vpc/subnets/us-west"

  vpc_id_west_2 = module.vpc-west.vpc_id_west_2
}

module "subnets_us_east" {
  source = "./modules/vpc/subnets/us-east"
  vpc_id_east_1 = module.vpc-east.vpc_id_east_1
}

module "ec2" {
  source = "./modules/ec2/ec2-east"
  
  us_east_subnet_1_id = module.subnets_us_east.us_east_subnet_1_id
  us_east_subnet_2_id = module.subnets_us_east.us_east_subnet_2_id
  us_east_subnet_3_id = module.subnets_us_east.us_east_subnet_3_id

  vpc_id_east_1 =  module.vpc-east.vpc_id_east_1 
}

module "ec2-west" {
  source = "./modules/ec2/ec2-west"
  
  us_west_subnet_1_id = module.subnets_us_west.us_west_subnet_1_id
  us_west_subnet_2_id = module.subnets_us_west.us_west_subnet_2_id
  us_west_subnet_3_id = module.subnets_us_west.us_west_subnet_3_id
  
  vpc_id_west_2 =  module.vpc-west.vpc_id_west_2
}


module "elb" {
  source = "./modules/elb"
}

module "efs" {
    source = "./modules/efs"
}
