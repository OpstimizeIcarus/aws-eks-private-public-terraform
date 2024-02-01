resource "aws_vpc_endpoint" "vpc_endpoints" {
  depends_on          = [aws_vpc.vpc, aws_security_group.vpc_endpoint_sg]
  count               = length(var.vpc_endpoints)
  vpc_id              = aws_vpc.vpc.id
  service_name        = var.vpc_endpoints[count.index]
  vpc_endpoint_type   = can(regex("s3$", var.vpc_endpoints[count.index])) ? "Gateway" : "Interface"
  private_dns_enabled = can(regex("s3$", var.vpc_endpoints[count.index])) ? null : true

  subnet_ids      = can(regex("s3$", var.vpc_endpoints[count.index])) ? null : aws_subnet.eks_subnet[*].id
  route_table_ids = can(regex("s3$", var.vpc_endpoints[count.index])) ? aws_route_table.eks_subnet_rt[*].id : null

  security_group_ids = can(regex("s3$", var.vpc_endpoints[count.index])) ? null : [aws_security_group.vpc_endpoint_sg.id]
}