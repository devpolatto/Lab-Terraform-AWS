resource "aws_security_group" "lab-001" {
  # name   = "lab-001"
  vpc_id = "vpc-04b508b307a73abbf"

  // To Allow SSH Transport
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Necessary if changing 'name' or 'name_prefix' properties.
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "sg-lab-001"
    env = "lab"
    lab-id = "lab-001"
  }
}