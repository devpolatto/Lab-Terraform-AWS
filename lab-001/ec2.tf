resource "aws_network_interface" "nint-machine-01" {
  subnet_id       = data.aws_subnet.my-snet-lab.id
  private_ips     = ["192.168.10.20"]
  security_groups = [aws_security_group.lab-001.id]

  tags = {
    Name   = "machine-01"
    env    = "lab"
    lab_id = "lab-001"
  }
}

resource "aws_instance" "machine-01" {
  ami               = "ami-08c40ec9ead489470"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"

  key_name = aws_key_pair.kp_lab_001.id

  network_interface {
    network_interface_id = aws_network_interface.nint-machine-01.id
    device_index         = 0
  }

  tags = {
    Name   = "machine-01"
    env    = "lab"
    lab_id = "lab-001"
  }
}