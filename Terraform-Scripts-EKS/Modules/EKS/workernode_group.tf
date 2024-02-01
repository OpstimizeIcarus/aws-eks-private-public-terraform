data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.eks_cluster.version}/amazon-linux-2/recommended/release_version"
}

resource "aws_eks_node_group" "example" {
  depends_on = [
    aws_iam_role_policy_attachment.nodegroup_AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.nodegroup_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodegroup_AmazonEKSWorkerNodePolicy
  ]
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.proj}-nodegroup"
  version         = aws_eks_cluster.eks_cluster.version
  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  node_role_arn   = aws_iam_role.nodegroup_AmazonEKSNodeRole.arn
  subnet_ids      = var.eks_subnet_ids
  scaling_config {
    max_size     = 1
    min_size     = 1
    desired_size = 1
  }
}