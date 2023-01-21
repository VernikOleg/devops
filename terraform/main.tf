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
  access_key = ""
  secret_key = ""
  region = "us-east-1"
}

resource "aws_security_group" "sg" {
  name = "allow-all-sg-2"
  ingress {
    cidr_blocks = [
      "194.44.201.155/32" 
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }// Terraform removes the default rule
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
  }
    ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
  }// Terraform removes the default rule
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}


resource "aws_key_pair" "deployer" {
  key_name   = "terraform"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHIkQLIZmY3nwyfleV2mORe0gjESBYN+zgx2LYXBv/rJ2zX9w3EY/eYvwIrshEmFn5w4dSjKlovwvwMwz4xajDfN42orkYn6XKB8lSxYB0ARas186BAkFZGbYBXzdfKDrRNZd4xId2jdzMExIQkrJiMTUHZCKTbLEKK4UsCzPtww+EfMb8HFMch4F8obE3L+gPzKfhJYxZ4BwKK5pyv9ZaMRNww1XZYCzh5a6z0xOb7/LZkzjpAMnmtwpUVCKDCzNqJgYvzu/eaTxhUHEO71slv/o5Lm7Z4MlZikOHqDz+gPPNy/kQQ3QR1fYvo/qZIJbl3PCgK7HJpkiGAOFRny7lk3Qa8lXhrP4/2VS1311Oq3eHUo3Eb+C4plvXSTELwj7tel2XC2+4ixoqgltmGMKdKpMgLPeTBVVFM3Dr6gfSrIJbq9TxqUtlymcAVdlHVlycL4kZq9uaH/GOj8aLHf0AAI8X9V/8U8eVILmSYt+jUlgcIdg1eney2jsY588EpGM= olegkinrev@DESKTOP-PATO6GE"
}

resource "aws_instance" "app_server" {
  ami             = "ami-04b3c39a8a1c62b76"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.deployer.id
  vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = "DevOpsServerInstanceByViernikOleh2023"
  }
  user_data = file("run.sh")
}
