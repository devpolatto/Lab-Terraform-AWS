resource "aws_subnet" "subnet-public" {
  vpc_id            = local.vpc_id
  cidr_block        = "192.168.20.0/24"
  availability_zone = "${local.region}a"
  tags              = merge(var.common_tags, { Name = "snet-pub-002" })
}

resource "aws_route_table" "public" {
  vpc_id = local.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = local.igw_id
  }
  tags = merge(var.common_tags, { Name = "rt-public" })
}

resource "aws_route_table_association" "this" {
  subnet_id      = aws_subnet.subnet-public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_network_interface" "worker" {
  subnet_id       = aws_subnet.subnet-public.id
  private_ips     = ["192.168.20.10"]
  security_groups = [aws_security_group.private.id, aws_security_group.public.id]
  tags            = merge(var.common_tags, { Name = "Master" })
}

resource "aws_network_interface" "node" {
  for_each = {
    "Host1" = "node-k8s-1",
    "Host2" = "node-k8s-2",
    "Host3" = "node-k8s-3"
  }
  subnet_id         = aws_subnet.subnet-public.id
  ipv4_prefix_count = 2
  security_groups = [aws_security_group.private.id, aws_security_group.public.id]
  tags              = merge(var.common_tags, { Name = "${each.value}" })
}