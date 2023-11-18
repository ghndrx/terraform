provider "aws" {
    region = "us-west-2"
}

resource "aws_subnet" "us_west_subnet_1" {
    vpc_id     = var.vpc_id_west_2
    cidr_block = var.us_west_subnet_1_cidr_block
    availability_zone = var.us_west_subnet_1_az
    tags = {
        Name = "${var.region}_${var.us_west_subnet_1_az}_subnet"
    }
    map_public_ip_on_launch = true
    depends_on = [var.vpc_id_west_2]
}

resource "aws_subnet" "us_west_subnet_2" {
    vpc_id     = var.vpc_id_west_2
    cidr_block = var.us_west_subnet_2_cidr_block
    availability_zone = var.us_west_subnet_2_az
    tags = {
        Name = "${var.region}_${var.us_west_subnet_2_az}_subnet"
    }
    map_public_ip_on_launch = true
    depends_on = [var.vpc_id_west_2]
}

resource "aws_subnet" "us_west_subnet_3" {
    vpc_id     = var.vpc_id_west_2
    cidr_block = var.us_west_subnet_3_cidr_block
    availability_zone = var.us_west_subnet_3_az
    tags = {
        Name = "${var.region}_${var.us_west_subnet_3_az}_subnet"
    }
    map_public_ip_on_launch = true
    depends_on = [var.vpc_id_west_2]
}
