// Create a key pair using the public key from the variables file
resource "aws_key_pair" "a3-construcao-key" {
  key_name   = "a3-construcao-key"
  public_key = var.ssh_public_key
}

// Create an EC2 instance
resource "aws_instance" "a3-construcao-ec2" {
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.a3-construcao-key.key_name
  vpc_security_group_ids = [aws_security_group.a3-construcao-sg.id]
  subnet_id     = aws_subnet.a3-construcao-public-subnet-01.id

  tags = {
    Name = "App Server"
  }
}