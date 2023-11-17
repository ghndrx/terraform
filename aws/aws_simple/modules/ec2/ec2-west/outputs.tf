# output "public_ips" {
#   description = "Public IP addresses of the instances in the Auto Scaling group"
#   value       = [for i in data.aws_instances.asg_instances.ids : aws_instance[i].public_ip]
# }