variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
}

variable "us_west_subnet_1_id" {
  description = "The ID of the first US West subnet"
  type        = string
}

variable "us_west_subnet_2_id" {
  description = "The ID of the second US West subnet"
  type        = string
}

variable "us_west_subnet_3_id" {
  description = "The ID of the third US West subnet"
  type        = string
}

variable "region" {
  description = "The region to deploy to"
  type        = string
}