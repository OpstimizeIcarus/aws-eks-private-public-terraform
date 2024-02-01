resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.proj}"
  }
}

resource "aws_subnet" "eks_subnet" {
  count             = length(var.az)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.eks_subnet[count.index]
  availability_zone = var.az[count.index]

  tags = {
    Name = "${var.proj}-eks${count.index}"
  }
}

output "eks_subnet_ids" {
  description = "eks-subnet IDS"
  value       = aws_subnet.eks_subnet[*].id
}



