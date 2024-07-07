// Create a security group for EC2 instances
resource "aws_security_group" "a3-construcao-sg" {
  name   = "a3-construcao-sg"
  vpc_id = aws_vpc.a3-construcao-vpc.id

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
    Name = "a3-construcao-sg"
  }
}

// Create a security group for RDS instances
resource "aws_security_group" "a3-construcao-rds-sg" {
  name   = "a3-construcao-rds-sg"
  vpc_id = aws_vpc.a3-construcao-vpc.id

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
    Name = "a3-construcao-rds-sg"
  }
}
