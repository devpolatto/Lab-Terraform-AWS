######
## Public Access
######
resource "aws_security_group" "public" {
  name = "${lookup(var.common_tags, "LAB_ID", "sg_public")}-public"
  description = "internet source access"
  vpc_id = local.vpc_id

  tags = merge(var.common_tags, { Name = "sg-access_from_net - ${lookup(var.common_tags, "LAB_ID", "sg_public")}" })
}

resource "aws_security_group_rule" "to_net" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 
  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "ssh_from_net" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "http_from_net" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}

resource "aws_security_group_rule" "https_from_net" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}

######
## Private Access
######
resource "aws_security_group" "private" {
    name = "${lookup(var.common_tags, "LAB_ID", "sg_private")}-private"
  description = "intranet access"
  vpc_id = local.vpc_id

  tags = merge(var.common_tags, { Name = "sg-intranet_access - ${lookup(var.common_tags, "LAB_ID", "sg_private")}" })
}

# In the private SG, access between hosts is defined. 
# In this way, we define that a host can only receive
# requests from hosts belonging to the same subnet, 
# and that it can make requests to any host belonging 
# to the SG private

resource "aws_security_group_rule" "private_out" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 
  security_group_id = aws_security_group.private.id
}

resource "aws_security_group_rule" "private_in" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks = [aws_subnet.subnet-public.cidr_block]
 
  security_group_id = aws_security_group.private.id
}