module "dev_role" {
  source           = "../modules/eks-rbac-iam-group"
  eks_cluster_name = module.eks.cluster_id
  role_name        = "dev-role"
  users            = var.dev_users
}

module "admin_role" {
  source           = "../modules/eks-rbac-iam-group"
  eks_cluster_name = module.eks.cluster_id
  role_name        = "admin-role"
  users            = var.admin_users
}