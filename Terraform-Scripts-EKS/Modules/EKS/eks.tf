resource "aws_eks_cluster" "eks_cluster" {
  depends_on = [aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy]
  name       = "${var.proj}-eks-cluster"
  role_arn   = aws_iam_role.eksClusterRole.arn
  version    = var.eks_versions

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids              = var.eks_subnet_ids
  }

  access_config {
    authentication_mode = "API"
  }
}