
# Define variables
variable "min_size" {
    type        = number
    description = "Minimum number of instances in the Auto Scaling Group"
    default     = 1
}

variable "max_size" {
    type        = number
    description = "Maximum number of instances in the Auto Scaling Group"
    default     = 1
}
