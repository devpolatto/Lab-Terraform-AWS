resource "aws_security_group" "lab-003" {
  vpc_id = local.vpc_id

  // To Allow SSH Transport
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["189.127.160.144/32"]
  }

  // To Allow Port 80 HTTP Transport
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["189.127.160.144/32"]
  }

  // To Allow Port 80 HTTPs Transport
  ingress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["189.127.160.144/32"]
  }

  ingress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Necessary if changing 'name' or 'name_prefix' properties.
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, { Name = "sg-lab-003" })
}