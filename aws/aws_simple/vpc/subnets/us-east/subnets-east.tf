
provider "aws" {
    region = "us-east-1"
}

resource "aws_subnet" "us_east_subnet_1" {
    vpc_id     = aws_vpc.my_vpc.id
    cidr_block = var.us_east_subnet_1_cidr_block
    availability_zone = var.us_east_subnet_1_az
    tags = {
        Name = "${var.region}_${var.us_east_subnet_1_az}_subnet"
    }
}

resource "aws_subnet" "us_east_subnet_2" {
    vpc_id     = aws_vpc.my_vpc.id
    cidr_block = var.us_east_subnet_2_cidr_block
    availability_zone = var.us_east_subnet_2_az
    tags = {
        Name = "${var.region}_${var.us_east_subnet_2_az}_subnet"
    }
}

resource "aws_subnet" "us_east_subnet_3" {
    vpc_id     = aws_vpc.my_vpc.id
    cidr_block = var.us_east_subnet_3_cidr_block
    availability_zone = var.us_east_subnet_3_az
    tags = {
        Name = "${var.region}_${var.us_east_subnet_3_az}_subnet"
    }
}