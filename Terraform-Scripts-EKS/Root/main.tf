module "Network" {
  source        = "../Modules/Network"
  vpc_cidr      = var.vpc_cidr
  az            = var.az
  eks_subnet    = var.eks_subnet
  vpc_endpoints = var.vpc_endpoints
  proj          = var.proj
}

module "EKS" {
  depends_on     = [module.Network]
  source         = "../Modules/EKS"
  eks_versions   = var.eks_versions
  eks_subnet_ids = module.Network.eks_subnet_ids
  proj           = var.proj
}