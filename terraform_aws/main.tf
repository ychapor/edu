terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_instance" "apache_server" {
  ami           = var.ami
  instance_type = var.instance_type
  user_data     = file("apache_install.sh")

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "web-sg" {
  name = format("%s-sg", var.instance_name)
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
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.apache_server.id
}

output "instance_public_ip" {
  description = "EC2 instance public IP"
  value       = aws_instance.apache_server.public_ip
}

