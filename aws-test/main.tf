# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.0"
#     }
#   }
# }

provider "aws" {
  region     = "ap-south-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

resource "aws_instance" "test_instance" {
  ami = "ami-0767046d1677be5a0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name= "aws_key"
  user_data     =  "${file("installion.sh")}"
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress                = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa ABCD...="
}

output "fetched_info" {
  value = "aws_instance.test_instance.id"
}

resource "aws_instance" "web" {
  ami           = "ami-005e54dee72cc1d00"
  instance_type = "t2.micro"

  tags = {
    Name = "testwebServer"
  }
}