provider "aws" {
  region = "us-east-1"
  profile = "default"
}

// Create a key pair
resource "aws_key_pair" "prd01" {
  key_name   = "prd01"
  public_key = file("~/.ssh/prd01.pub")
}

resource "aws_instance" "ec2" {
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.prd01.key_name
  vpc_security_group_ids = [aws_security_group.rtp03-sg.id]
  subnet_id     = aws_subnet.rtp03-public_subnet_01.id
}

resource "aws_security_group" "rtp03-sg" {
  name   = "rtp03-sg"
  vpc_id = aws_vpc.rtp03-vpc.id

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh-sg"
  }
}

resource "aws_security_group" "rtp03-rds-sg" {
  name   = "rtp03-rds-sg"
  vpc_id = aws_vpc.rtp03-vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_vpc" "rtp03-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "rpt03-vpc"
  }
}

resource "aws_subnet" "rtp03-public_subnet_01" {
  vpc_id                 = aws_vpc.rtp03-vpc.id
  cidr_block             = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone      = "us-east-1a"
  tags = {
    Name = "rtp03-public_subnet_01"
  }
}

resource "aws_subnet" "rtp03-public_subnet_02" {
  vpc_id                 = aws_vpc.rtp03-vpc.id
  cidr_block             = "10.1.2.0/24"
  map_public_ip_on_launch = true
  availability_zone      = "us-east-1b"
  tags = {
    Name = "rtp03-public_subnet_02"
  }
}

resource "aws_internet_gateway" "rtp03-igw" {
  vpc_id = aws_vpc.rtp03-vpc.id
  tags = {
    Name = "rtp03-igw"
  }
}

resource "aws_route_table" "rtp03-public-rt" {
  vpc_id = aws_vpc.rtp03-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rtp03-igw.id
  }
  tags = {
    Name = "rtp03-public-rt"
  }
}

resource "aws_route_table_association" "rtp03-rta-public-subnet-1" {
  subnet_id     = aws_subnet.rtp03-public_subnet_01.id
  route_table_id = aws_route_table.rtp03-public-rt.id
}

resource "aws_route_table_association" "rtp03-rta-public-subnet-2" {
  subnet_id     = aws_subnet.rtp03-public_subnet_02.id
  route_table_id = aws_route_table.rtp03-public-rt.id
}

// Create a MySQL RDS instance
resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "construcaosoftware"
  username             = "admin"
  password             = "a3construcao"
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.rtp03-rds-sg.id]
  db_subnet_group_name = aws_db_subnet_group.default.name
  skip_final_snapshot  = true

  tags = {
    Name = "mydatabase"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [
    aws_subnet.rtp03-public_subnet_01.id,
    aws_subnet.rtp03-public_subnet_02.id
  ]

  tags = {
    Name = "main"
  }
}
