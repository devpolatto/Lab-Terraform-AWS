resource "aws_instance" "master" {
  ami                         = local.ec2.ami_id
  instance_type               = local.ec2.instance_type

  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet-public.id

  security_groups = [aws_security_group.lab-003.id]

  root_block_device {
    volume_size = 30
    volume_type = "standard"
  }

  user_data = "${file("user-data.sh")}"

  tags = merge(var.common_tags, { Name = "Master" })
}

resource "aws_instance" "node" {
  count = 3
  ami                         = local.ec2.ami_id
  instance_type               = local.ec2.instance_type

  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet-public.id

  security_groups = [aws_security_group.lab-003.id]

  root_block_device {
    volume_size = 30
    volume_type = "standard"
  }

  user_data = "${file("user-data.sh")}"

  tags = merge(var.common_tags, { Name = "node-k8s-00${count.index+1}"})
}