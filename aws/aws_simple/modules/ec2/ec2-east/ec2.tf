provider "aws" {
    region = "us-east-1"
}
# Create a security group for the EC2 instance
resource "aws_security_group" "instance-east" {
    name_prefix = "instance-east-"
    vpc_id      = var.vpc_id_east_1

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
        Name = "instance-security-group-east"
    }
}

# Define the Launch Configuration
resource "aws_launch_configuration" "lc-east" {
    name_prefix   = "lc-east-"
    image_id = "ami-0237a465e7f465b10" 
    instance_type = "t3.small"
    security_groups = [
        aws_security_group.instance-east.id
    ]
    user_data = file("${path.module}/user-data.sh")
    root_block_device {
        volume_size = 300
    }
}

# Define the Auto Scaling Group
resource "aws_autoscaling_group" "asg-east" {
    name_prefix                 = "asg-east-"
    launch_configuration       = aws_launch_configuration.lc-east.id
    depends_on = [ 
        aws_launch_configuration.lc-east,
    ]
    vpc_zone_identifier         = [
        var.us_east_subnet_1_id,
        var.us_east_subnet_2_id,
        var.us_east_subnet_3_id,
    ]
    min_size                    = var.min_size
    max_size                    = var.max_size
    desired_capacity            = var.min_size
    health_check_grace_period   = 300
    health_check_type           = "EC2"
    termination_policies        = ["OldestInstance"]
    tag {
        key                 = "Name"
        value               = "asg-instance-east"
        propagate_at_launch = true
    }
}

data "aws_instances" "asg_instances-east" {
  instance_tags = {
    "aws:autoscaling:groupName" = aws_autoscaling_group.asg-east.name
  }
}
