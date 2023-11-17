output "vpc_id_east_1" {
    value = aws_vpc.vpc_us_east_1.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.vpc_us_east_1.cidr_block
}