resource "aws_route_table" "eks_subnet_rt" {
  count  = length(aws_subnet.eks_subnet[*].id)
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
  tags = {
    Name = "${var.proj}-eks-rt${count.index}"
  }
}

resource "aws_route_table_association" "eks_subnet_rt_as" {
  count          = length(aws_route_table.eks_subnet_rt[*].id)
  subnet_id      = aws_subnet.eks_subnet[count.index].id
  route_table_id = aws_route_table.eks_subnet_rt[count.index].id
}