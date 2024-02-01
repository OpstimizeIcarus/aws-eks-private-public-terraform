resource "aws_security_group" "vpc_endpoint_sg" {
  name   = "${var.proj}-endpoint-sg"
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.proj}-endpoint-sg"
  }
}

resource "aws_security_group_rule" "vpc_endpoint_sg_rule" {
  security_group_id = aws_security_group.vpc_endpoint_sg.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
}