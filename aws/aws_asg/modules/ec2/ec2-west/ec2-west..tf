provider "aws" {
    region = "us-west-2"
}

# Create a security group for the EC2 instance
resource "aws_security_group" "instance-west" {
    name_prefix = "instance-west-"
    vpc_id      = var.vpc_id_west_2
    # HTTP access
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # HTTPS access
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # SSH access
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "instance-security-group-west"
    }
}

# Define the Launch Template
resource "aws_launch_template" "lt-west" {
    name_prefix   = "lt-west"
    image_id = "ami-03bf1eb153d14803f" 
    instance_type = "t3.small"
    user_data = base64encode(file("${path.module}/user-data.sh"))
    block_device_mappings {
        device_name = "/dev/xvda"
        ebs {
            volume_size = 300
        }
    }
    network_interfaces {
        associate_public_ip_address = true
        security_groups = [aws_security_group.instance-west.id]

    }
}

# Define the Auto Scaling Group
resource "aws_autoscaling_group" "asg-west" {
    name_prefix                 = "asg-west-"
    launch_template {
        id      = aws_launch_template.lt-west.id
        version = "$Latest"
    }    
    vpc_zone_identifier         = [
        var.us_west_subnet_1_id,
        var.us_west_subnet_2_id,
        var.us_west_subnet_3_id
    ]
    min_size                    = var.min_size
    max_size                    = var.max_size
    desired_capacity            = var.min_size
    health_check_grace_period   = 300
    health_check_type           = "EC2"
    termination_policies        = ["OldestInstance"]
    tag {
        key                 = "Name"
        value               = "asg-instance-west"
        propagate_at_launch = true
    }
    depends_on = [
        aws_security_group.instance-west,
        aws_launch_template.lt-west
    ]
}

data "aws_instances" "asg_instances-west" {
  instance_tags = {
    "aws:autoscaling:groupName" = aws_autoscaling_group.asg-west.name
  }
}
