variable "vpc_cidr_block" {
    default = "10.1.0.0/16"
}

variable "us_east_subnet_1_id" {
  description = "The ID of the first US East subnet"
  type        = string
}

variable "us_east_subnet_2_id" {
  description = "The ID of the second US East subnet"
  type        = string
}

variable "us_east_subnet_3_id" {
  description = "The ID of the third US East subnet"
  type        = string
}

variable "region" {
  description = "The region to deploy to"
  type        = string
}