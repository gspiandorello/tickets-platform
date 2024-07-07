// Create a VPC
resource "aws_vpc" "a3-construcao-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "a3-construcao-vpc"
  }
}

// Create a public subnet in AZ us-east-1a
resource "aws_subnet" "a3-construcao-public-subnet-01" {
  vpc_id                 = aws_vpc.a3-construcao-vpc.id
  cidr_block             = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone      = "us-east-1a"
  tags = {
    Name = "a3-construcao-public-subnet-01"
  }
}

// Create a public subnet in AZ us-east-1b
resource "aws_subnet" "a3-construcao-public-subnet-02" {
  vpc_id                 = aws_vpc.a3-construcao-vpc.id
  cidr_block             = "10.1.2.0/24"
  map_public_ip_on_launch = true
  availability_zone      = "us-east-1b"
  tags = {
    Name = "a3-construcao-public-subnet-02"
  }
}

// Create an Internet Gateway
resource "aws_internet_gateway" "a3-construcao-igw" {
  vpc_id = aws_vpc.a3-construcao-vpc.id
  tags = {
    Name = "a3-construcao-igw"
  }
}

// Create a route table
resource "aws_route_table" "a3-construcao-public-rt" {
  vpc_id = aws_vpc.a3-construcao-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.a3-construcao-igw.id
  }
  tags = {
    Name = "a3-construcao-public-rt"
  }
}

// Associate the first subnet with the route table
resource "aws_route_table_association" "a3-construcao-rta-public-subnet-1" {
  subnet_id     = aws_subnet.a3-construcao-public-subnet-01.id
  route_table_id = aws_route_table.a3-construcao-public-rt.id
}

// Associate the second subnet with the route table
resource "aws_route_table_association" "a3-construcao-rta-public-subnet-2" {
  subnet_id     = aws_subnet.a3-construcao-public-subnet-02.id
  route_table_id = aws_route_table.a3-construcao-public-rt.id
}
