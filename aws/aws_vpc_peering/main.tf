terraform {
    backend "s3" {
        bucket = "my-tf-bucket-ghndrx"
        key    = "aws_vpc_peering/terraform.tfstate"
        region = "us-west-2"
    }
}

# Define AWS provider with aliases for us-west-1 and us-east-1 regions
provider "aws" {
    alias  = "us-west-1"
    region = "us-west-1"
}

provider "aws" {
    alias  = "us-east-1"
    region = "us-east-1"
}

# Create VPCs in us-west-1 and us-east-1 regions
resource "aws_vpc" "us-west-1" {
    cidr_block = "10.0.0.0/16"
    provider   = aws.us-west-1
}

resource "aws_vpc" "us-east-1" {
    cidr_block = "10.1.0.0/16"
    provider   = aws.us-east-1
}

# Create subnets in us-west-1 VPC
resource "aws_subnet" "us-west-1-subnet-1" {
    vpc_id            = aws_vpc.us-west-1.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-west-1c"
    provider = aws.us-west-1
}

resource "aws_subnet" "us-west-1-subnet-2" {
    vpc_id            = aws_vpc.us-west-1.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-west-1b"
    provider = aws.us-west-1
}

# Create subnets in us-east-1 VPC
resource "aws_subnet" "us-east-1-subnet-1" {
    vpc_id            = aws_vpc.us-east-1.id
    cidr_block        = "10.1.1.0/24"
    availability_zone = "us-east-1c"
    provider = aws.us-east-1
}



resource "aws_subnet" "us-east-1-subnet-2" {
    vpc_id            = aws_vpc.us-east-1.id
    cidr_block        = "10.1.2.0/24"
    availability_zone = "us-east-1b"
    provider = aws.us-east-1
}

# Create VPC peering connection between us-west-1 and us-east-1 VPCs
resource "aws_vpc_peering_connection" "peering_connection" {
    vpc_id        = aws_vpc.us-west-1.id
    peer_vpc_id   = aws_vpc.us-east-1.id
    peer_region   = "us-east-1"
    auto_accept   = false
    provider = aws.us-west-1
}

# Create VPC peering connection accepter in us-east-1 region
resource "aws_vpc_peering_connection_accepter" "peering_accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  auto_accept = true

  provider = aws.us-east-1
}

resource "aws_route" "peer-route-us-west-1" {
  route_table_id            = aws_route_table.us-west-1-route-table.id
  destination_cidr_block    = aws_vpc.us-east-1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  provider = aws.us-west-1
}

resource "aws_route" "peer-route-us-east-1" {
  route_table_id            = aws_route_table.us-east-1-route-table.id
  destination_cidr_block    = aws_vpc.us-west-1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  provider = aws.us-east-1
}

# Create route tables for each VPC and associate them with the respective subnets
resource "aws_route_table" "us-west-1-route-table" {
    vpc_id = aws_vpc.us-west-1.id
    provider = aws.us-west-1
}

resource "aws_route_table_association" "us-west-1-subnet-1-association" {
    subnet_id      = aws_subnet.us-west-1-subnet-1.id
    route_table_id = aws_route_table.us-west-1-route-table.id
    provider = aws.us-west-1
}

resource "aws_route_table_association" "us-west-1-subnet-2-association" {
    subnet_id      = aws_subnet.us-west-1-subnet-2.id
    route_table_id = aws_route_table.us-west-1-route-table.id
    provider = aws.us-west-1
}

resource "aws_route_table" "us-east-1-route-table" {
    vpc_id = aws_vpc.us-east-1.id
    provider = aws.us-east-1
}

resource "aws_route_table_association" "us-east-1-subnet-1-association" {
    subnet_id      = aws_subnet.us-east-1-subnet-1.id
    route_table_id = aws_route_table.us-east-1-route-table.id
    provider = aws.us-east-1
}

resource "aws_route_table_association" "us-east-1-subnet-2-association" {
    subnet_id      = aws_subnet.us-east-1-subnet-2.id
    route_table_id = aws_route_table.us-east-1-route-table.id
    provider = aws.us-east-1
}


# Create internet gateway for us-west-1 VPC
resource "aws_internet_gateway" "us-west-1-igw" {
    vpc_id = aws_vpc.us-west-1.id
    provider = aws.us-west-1

    tags = {
        Name = "us-west-1-igw"
    }
}

# Create internet gateway for us-east-1 VPC
resource "aws_internet_gateway" "us-east-1-igw" {
    vpc_id = aws_vpc.us-east-1.id
    provider = aws.us-east-1

    tags = {
        Name = "us-east-1-igw"
    }
}

# Attach internet gateway to the route table of each VPC
resource "aws_route" "us-west-1-igw-route" {
    route_table_id         = aws_route_table.us-west-1-route-table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.us-west-1-igw.id
    provider               = aws.us-west-1
}

resource "aws_route" "us-east-1-igw-route" {
    route_table_id         = aws_route_table.us-east-1-route-table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.us-east-1-igw.id
    provider               = aws.us-east-1
}

# Create security groups for EC2 instances
resource "aws_security_group" "us-west-1-instance-sg" {
    vpc_id    = aws_vpc.us-west-1.id
    provider  = aws.us-west-1
    tags = {
        Name = "instance-west-security-group"
    }

    # Allow inbound SSH, HTTP, and HTTPS traffic from any source
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

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

    # Allow outbound traffic to all private subnets in the VPC
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["10.1.0.0/16", "0.0.0.0/0"]
    }
        ingress {
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "us-east-1-instance-sg" {
    vpc_id    = aws_vpc.us-east-1.id
    provider  = aws.us-east-1
    tags = {
        Name = "instance-east-security-group"
    }

    # Allow inbound SSH, HTTP, and HTTPS traffic from any source
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

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

    # Allow outbound traffic to all private subnets in the VPC
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["10.1.0.0/16", "0.0.0.0/0"]
    }
    ingress {
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Create EC2 instances in each subnet
resource "aws_instance" "us-west-1-instance-1" {
    ami                    = "ami-0f3f6663da6750955"  # Ubuntu 20.04 AMI
    instance_type          = "t3.small"  # Add instance type
    subnet_id              = aws_subnet.us-west-1-subnet-1.id
    vpc_security_group_ids = [aws_security_group.us-west-1-instance-sg.id]
    associate_public_ip_address = true  # Set ephemeral public IP address
    user_data = base64encode(file("${path.module}/user-data.sh"))
    # Other necessary configurations for the instance
    provider = aws.us-west-1
    # ...
    tags = {
        Name = "us-west-1-instance-1"
        SecurityGroup = "instance-west-security-group"
    }
}

resource "aws_instance" "us-west-1-instance-2" {
    ami                    = "ami-0f3f6663da6750955"  # Ubuntu 20.04 AMI
    instance_type          = "t3.small"  # Add instance type
    subnet_id              = aws_subnet.us-west-1-subnet-2.id
    vpc_security_group_ids = [aws_security_group.us-west-1-instance-sg.id]
    associate_public_ip_address = true  # Set ephemeral public IP address
    user_data = base64encode(file("${path.module}/user-data.sh"))
    # Other necessary configurations for the instance
    provider = aws.us-west-1
    # ...
    tags = {
        Name = "us-west-1-instance-2"
        SecurityGroup = "instance-west-security-group"
    }
}

resource "aws_instance" "us-east-1-instance-1" {
    ami                    = "ami-04e369782a6d2125e"  # Ubuntu 20.04 AMI
    instance_type          = "t3.small"  # Add instance type
    subnet_id              = aws_subnet.us-east-1-subnet-1.id
    vpc_security_group_ids = [aws_security_group.us-east-1-instance-sg.id]
    associate_public_ip_address = true  # Set ephemeral public IP address
    user_data = base64encode(file("${path.module}/user-data.sh"))
    # Other necessary configurations for the instance
    provider = aws.us-east-1
    # ...
    tags = {
        Name = "us-east-1-instance-1"
        SecurityGroup = "instance-east-security-group"
    }
}

resource "aws_instance" "us-east-1-instance-2" {
    ami                    = "ami-04e369782a6d2125e"  # Ubuntu 20.04 AMI
    instance_type          = "t3.small"  # Add instance type
    subnet_id              = aws_subnet.us-east-1-subnet-2.id
    vpc_security_group_ids = [aws_security_group.us-east-1-instance-sg.id]
    associate_public_ip_address = true  # Set ephemeral public IP address
    user_data = base64encode(file("${path.module}/user-data.sh"))
    # Other necessary configurations for the instance
    provider = aws.us-east-1
    # ...
    tags = {
        Name = "us-east-1-instance-2"
        SecurityGroup = "instance-east-security-group"
    }
}

# ...

output "us-west-1-instance-1-public-ip" {
    value = aws_instance.us-west-1-instance-1.public_ip
}

output "us-west-1-instance-2-public-ip" {
    value = aws_instance.us-west-1-instance-2.public_ip
}

output "us-east-1-instance-1-public-ip" {
    value = aws_instance.us-east-1-instance-1.public_ip
}

output "us-east-1-instance-2-public-ip" {
    value = aws_instance.us-east-1-instance-2.public_ip
}


