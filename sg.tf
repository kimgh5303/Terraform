resource "aws_security_group" "mysg" {
  vpc_id      = aws_vpc.myvpc.id
  name        = var.mysg.name
  description = var.mysg.description
}

resource "aws_security_group_rule" "mysginbound" {
  type              = var.mysginbound.type
  from_port         = var.mysginbound.from_port
  to_port           = var.mysginbound.to_port
  protocol          = var.mysginbound.protocol
  cidr_blocks       = var.mysginbound.cidr_blocks
  security_group_id = aws_security_group.mysg.id
}

resource "aws_security_group_rule" "mysgoutbound" {
  type              = var.mysgoutbound.type
  from_port         = var.mysgoutbound.from_port
  to_port           = var.mysgoutbound.to_port
  protocol          = var.mysgoutbound.protocol
  cidr_blocks       = var.mysgoutbound.cidr_blocks
  security_group_id = aws_security_group.mysg.id
}