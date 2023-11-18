variable "us_west_subnet_1_cidr_block" {
    default = "10.0.1.0/24"
}

variable "us_west_subnet_2_cidr_block" {
    default = "10.0.2.0/24"
}

variable "us_west_subnet_3_cidr_block" {
    default = "10.0.3.0/24"
}


variable "us_west_subnet_1_az" {
    default = "us-west-2a"
}

variable "us_west_subnet_2_az" {
    default = "us-west-2b"
}

variable "us_west_subnet_3_az" {
    default = "us-west-2c"
}

variable "region" {
    default = "us-west-2"
}


variable "vpc_id_west_2" {
  description = "The ID of the VPC"
  type        = string
}