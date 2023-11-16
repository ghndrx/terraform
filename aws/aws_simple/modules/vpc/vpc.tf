#Create aws vpc
resource "aws_vpc" "vpc_us" {
    cidr_block = var.vpc_cidr_block
        tags = {
        Name = "vpc_us"
        Environment = "production"
    }
}
# Create aws internet gateway 
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.vpc_us.id
}

# Create route table entries for the west subnets
resource "aws_route_table" "us_west_route_table" {
    vpc_id = aws_vpc.vpc_us.id
}

# Create route table entries for the east subnets
resource "aws_route_table" "us_east_route_table" {
    vpc_id = aws_vpc.vpc_us.id
}

resource "aws_route" "us_west_route" {
    route_table_id         = aws_route_table.us_west_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.my_igw.id
}

resource "aws_route" "us_east_route" {
    route_table_id         = aws_route_table.us_east_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.my_igw.id
}

resource "aws_route_table_association" "us_west_subnet_1_association" {
    subnet_id      = var.us_west_subnet_1_id
    route_table_id = aws_route_table.us_west_route_table.id
}

resource "aws_route_table_association" "us_west_subnet_2_association" {
    subnet_id      = var.us_west_subnet_2_id
    route_table_id = aws_route_table.us_west_route_table.id
}

resource "aws_route_table_association" "us_west_subnet_3_association" {
    subnet_id      = var.us_west_subnet_3_id
    route_table_id = aws_route_table.us_west_route_table.id
}

resource "aws_route_table_association" "us_east_subnet_1_association" {
    subnet_id      = var.us_east_subnet_1_id
    route_table_id = aws_route_table.us_east_route_table.id
}

resource "aws_route_table_association" "us_east_subnet_2_association" {
    subnet_id      = var.us_east_subnet_2_id
    route_table_id = aws_route_table.us_east_route_table.id
}

resource "aws_route_table_association" "us_east_subnet_3_association" {
    subnet_id      = var.us_east_subnet_3_id
    route_table_id = aws_route_table.us_east_route_table.id
}

