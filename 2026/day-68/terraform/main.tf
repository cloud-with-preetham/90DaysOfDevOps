provider "aws" {
  region = var.region
}

resource "aws_key_pair" "ansible_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "ansible_sg" {
  name = "ansible-sg"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "servers" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type

  key_name        = aws_key_pair.ansible_key.key_name
  security_groups = [aws_security_group.ansible_sg.name]

  tags = {
    Name = element(["web-server", "app-server", "db-server"], count.index)
  }
}
