terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1a"
  profile = "polatto_tf"
}

resource "aws_instance" "ngix-web-server" {
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  tags          = var.instance_tags_nginx
}

resource "aws_instance" "dns-server" {
  ami           = "ami-08c40ec9ead489470"
  instance_type = "t2.micro"
  tags          = var.instance_tags_dns
}