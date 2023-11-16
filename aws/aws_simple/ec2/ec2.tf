# Define the VPC and subnets data sources
data "aws_vpc" "vpc" {
    id = data.aws_subnet.subnet1.vpc_id
}

module "vpc_subnets" {
  source = "../vpc/subnets"
}

data "aws_subnet" "subnet1" {
    id = module.vpc_subnets.subnet_ids[0]
}

data "aws_subnet" "subnet2" {
    id = module.vpc_subnets.subnet_ids[1]
}

data "aws_subnet" "subnet3" {
    id = module.vpc_subnets.subnet_ids[2]
}

data "aws_subnet" "subnet4" {
    id = module.vpc_subnets.subnet_ids[3]
}

data "aws_subnet" "subnet5" {
    id = module.vpc_subnets.subnet_ids[4]
}

data "aws_subnet" "subnet6" {
    id = module.vpc_subnets.subnet_ids[5]
}

# Create a security group for the EC2 instance
resource "aws_security_group" "instance" {
    name_prefix = "instance-"
    vpc_id      = data.aws_vpc.vpc.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "instance-security-group"
    }
}

# Define the Launch Configuration
resource "aws_launch_configuration" "lc" {
    name_prefix   = "lc-"
    image_id      = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
    instance_type = "t3.small"
    security_groups = [
        aws_security_group.instance.id
    ]
    user_data = file("${path.module}/user-data.sh")
    root_block_device {
        volume_size = 20
    }
}

# Define the Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
    name_prefix                 = "asg-"
    launch_configuration       = aws_launch_configuration.lc.id
    vpc_zone_identifier         = [
        data.aws_subnet.subnet1.id,
        data.aws_subnet.subnet2.id
    ]
    min_size                    = var.min_size
    max_size                    = var.max_size
    desired_capacity            = var.min_size
    health_check_grace_period   = 300
    health_check_type           = "EC2"
    termination_policies        = ["OldestInstance"]
    tag {
        key                 = "Name"
        value               = "asg-instance"
        propagate_at_launch = true
    }
}

# Output the instance public IP address
output "public_ip" {
    value = aws_autoscaling_group.asg.instances[0].public_ip
}
