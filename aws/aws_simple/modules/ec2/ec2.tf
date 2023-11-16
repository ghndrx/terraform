# Define the VPC and subnets data sources
data "aws_vpc" "vpc" {
    id = var.vpc_id
}

data "aws_subnet" "subnet1" {
    id = var.us_east_subnet_1_id
}

data "aws_subnet" "subnet2" {
    id = var.us_east_subnet_2_id
}

data "aws_subnet" "subnet3" {
    id = var.us_east_subnet_3_id
}

data "aws_subnet" "subnet4" {
    id = var.us_west_subnet_1_id
}

data "aws_subnet" "subnet5" {
    id = var.us_west_subnet_2_id
}

data "aws_subnet" "subnet6" {
    id = var.us_west_subnet_3_id
}

# Create a security group for the EC2 instance
resource "aws_security_group" "instance" {
    name_prefix = "instance-"
    vpc_id      = var.vpc_id

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
    depends_on = [ 
        var.vpc_id, 
        aws_launch_configuration.lc,
        data.aws_subnet.subnet1,
        data.aws_subnet.subnet2,
        data.aws_subnet.subnet3,
        data.aws_subnet.subnet4,
        data.aws_subnet.subnet5,
        data.aws_subnet.subnet6
    ]
    vpc_zone_identifier         = [
        data.aws_subnet.subnet1.id,
        data.aws_subnet.subnet2.id,
        data.aws_subnet.subnet3.id,
        data.aws_subnet.subnet4.id,
        data.aws_subnet.subnet5.id,
        data.aws_subnet.subnet6.id
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

data "aws_instances" "asg_instances" {
  instance_tags = {
    "aws:autoscaling:groupName" = aws_autoscaling_group.asg.name
  }
}
