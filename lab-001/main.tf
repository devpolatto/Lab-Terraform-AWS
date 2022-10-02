terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.3"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "polatto_tf"
}

// getting subnet id
data "aws_subnet" "my-snet-lab" {
  vpc_id = "vpc-04b508b307a73abbf"
  tags = {
    "snet-type" = "public"
  }
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits = 4096
}

variable "keypair_name" {
  type = string
  default = "kp_lab001"
}

resource "aws_key_pair" "kp_lab_001" {
  key_name = var.keypair_name
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./${var.keypair_name}.pem"
  }

  tags = {
    env    = "lab"
    lab_id = "lab-001"
  }
}

output "ec2-public-ip" {
  value = {
    "Private  IP" : aws_instance.machine-01.private_ip,
    "Public IP" : try(aws_instance.machine-01.public_ip, ""),
    "Key_pair" : aws_key_pair.kp_lab_001.key_name,
    "Access" : "ssh -i '${aws_key_pair.kp_lab_001.key_name}.pem' ubuntu@${aws_instance.machine-01.public_ip}"
  }
}