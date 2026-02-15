terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-north-1"
}

# SSH KEY
resource "aws_key_pair" "my_key" {
  key_name   = "ansible-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "web_sg" {
  name        = "web-security-group"
  description = "Allow HTTP and SSH traffic"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
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
    Name = "web-sg"
  }
}

resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-073130f74f5ffb161"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "Terraformbatch-Instance"
  }
}

output "ec2_public_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.my_ec2_instance.public_dns
}

output "security_group_id" {
  value = aws_security_group.web_sg.id
}






