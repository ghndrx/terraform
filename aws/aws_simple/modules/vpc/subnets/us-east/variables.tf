variable "us_east_subnet_1_az" {
    default = "us-east-1a"
}

variable "us_east_subnet_2_az" {
    default = "us-east-1b"
}

variable "us_east_subnet_3_az" {
    default = "us-east-1c"
}

variable "region" {
    default = "us-east-1"
}


variable "us_east_subnet_1_cidr_block" {
    default = "10.1.4.0/24"
}

variable "us_east_subnet_2_cidr_block" {
    default = "10.1.5.0/24"
}

variable "us_east_subnet_3_cidr_block" {
    default = "10.1.6.0/24"
}

variable "vpc_id_east_1" {
  description = "The ID of the VPC"
  type        = string
}

