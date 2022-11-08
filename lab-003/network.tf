resource "aws_subnet" "this" {
  for_each = {
    "pub" = ["192.168.20.0/24", "${var.aws_region}a", "snet-pub-002"]
    "priv" = ["192.168.30.0/24", "${var.aws_region}b", "snet-priv-002"]
  }
  vpc_id            = local.vpc_id
  cidr_block        = each.value[0]
  availability_zone = each.value[1]
  tags              = merge(var.common_tags, { Name = each.value[2] })
}

resource "aws_route_table" "public" {
  vpc_id            = local.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = local.igw_id
  }
  tags              = merge(var.common_tags, { Name = "rt-public" })
}

resource "aws_route_table" "private" {
  vpc_id            = local.vpc_id
  tags              = merge(var.common_tags, { Name = "rt-private" })
}

resource "aws_route_table_association" "this" {
  for_each = {for k, v in aws_subnet.this : v.tags.Name => v.id}
  subnet_id = each.value
  route_table_id = substr(each.key, 5, 3) == "pub" ? aws_route_table.public.id : aws_route_table.private.id
}

resource "aws_network_interface" "this" {

  subnet_id       = # public subnet id
  private_ips     = # List of ips of the variable "hosts_inventory"
  security_groups = [aws_security_group.lab-003.id]

  tags              = merge(var.common_tags, { Name = each.value[1] })
}