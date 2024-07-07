// Create a MySQL RDS instance
resource "aws_db_instance" "a3-construcao-db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.a3-construcao-rds-sg.id]
  db_subnet_group_name = aws_db_subnet_group.a3-construcao-db-subnet-group.name
  skip_final_snapshot  = true

  tags = {
    Name = var.db_name
  }
}

// Create a DB subnet group
resource "aws_db_subnet_group" "a3-construcao-db-subnet-group" {
  name       = "a3-construcao-db-subnet-group"
  subnet_ids = [
    aws_subnet.a3-construcao-public-subnet-01.id,
    aws_subnet.a3-construcao-public-subnet-02.id
  ]

  tags = {
    Name = "a3-construcao-db-subnet-group"
  }
}
