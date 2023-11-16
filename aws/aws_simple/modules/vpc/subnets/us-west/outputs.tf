# In your vpc/subnets/us-east module

output "us_west_subnet_1_id" {
  description = "The ID of the first US East subnet"
  value       = aws_subnet.us_west_subnet_1.id
}

output "us_west_subnet_2_id" {
  description = "The ID of the second US East subnet"
  value       = aws_subnet.us_west_subnet_2.id
}

output "us_west_subnet_3_id" {
  description = "The ID of the third US East subnet"
  value       = aws_subnet.us_west_subnet_3.id
}