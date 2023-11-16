#Create aws vpc
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr_block
        tags = {
        Name = "production-vpc"
        Environment = "production"
    }
}
# Create aws internet gateway 
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
}

# Create route table entries for the west subnets
resource "aws_route_table" "us_west_route_table" {
    vpc_id = aws_vpc.my_vpc.id
}

# Create route table entries for the east subnets
resource "aws_route_table" "us_east_route_table" {
    vpc_id = aws_vpc.my_vpc.id
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
    subnet_id      = aws_subnet.us_west_subnet_1.id
    route_table_id = aws_route_table.us_west_route_table.id
}

resource "aws_route_table_association" "us_west_subnet_2_association" {
    subnet_id      = aws_subnet.us_west_subnet_2.id
    route_table_id = aws_route_table.us_west_route_table.id
}

resource "aws_route_table_association" "us_west_subnet_3_association" {
    subnet_id      = aws_subnet.us_west_subnet_3.id
    route_table_id = aws_route_table.us_west_route_table.id
}

resource "aws_route_table_association" "us_east_subnet_1_association" {
    subnet_id      = aws_subnet.us_east_subnet_1.id
    route_table_id = aws_route_table.us_east_route_table.id
}

resource "aws_route_table_association" "us_east_subnet_2_association" {
    subnet_id      = aws_subnet.us_east_subnet_2.id
    route_table_id = aws_route_table.us_east_route_table.id
}

resource "aws_route_table_association" "us_east_subnet_3_association" {
    subnet_id      = aws_subnet.us_east_subnet_3.id
    route_table_id = aws_route_table.us_east_route_table.id
}

