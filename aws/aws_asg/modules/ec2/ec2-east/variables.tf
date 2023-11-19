
# Define variables
variable "min_size" {
    type        = number
    description = "Minimum number of instances in the Auto Scaling Group"
}

variable "max_size" {
    type        = number
    description = "Maximum number of instances in the Auto Scaling Group"
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

variable "vpc_id_east_1" {
  description = "The ID of the VPC"
  type        = string
}



