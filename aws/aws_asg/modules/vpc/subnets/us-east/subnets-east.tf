provider "aws" {
    region = "us-east-1"
}

resource "aws_subnet" "us_east_subnet_1" {
    vpc_id     = var.vpc_id_east_1
    cidr_block = var.us_east_subnet_1_cidr_block
    availability_zone = var.us_east_subnet_1_az
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.region}_${var.us_east_subnet_1_az}_subnet"
    }
}

resource "aws_subnet" "us_east_subnet_2" {
    vpc_id     = var.vpc_id_east_1
    cidr_block = var.us_east_subnet_2_cidr_block
    availability_zone = var.us_east_subnet_2_az
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.region}_${var.us_east_subnet_2_az}_subnet"
    }
}

resource "aws_subnet" "us_east_subnet_3" {
    vpc_id     = var.vpc_id_east_1
    cidr_block = var.us_east_subnet_3_cidr_block
    availability_zone = var.us_east_subnet_3_az
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.region}_${var.us_east_subnet_3_az}_subnet"
    }
}