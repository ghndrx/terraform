output "vpc_id_west_2" {
    value = aws_vpc.vpc_us_west_2.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.vpc_us_west_2.cidr_block
}