output "dev_role_arn" {
  value = module.dev_role.arn
}

output "admin_role_arn" {
  value = module.admin_role.arn
}

output "cluster_worker_role" {
  value = module.eks.worker_iam_role_arn
}

output "worker_iam_role_arn" {
  value = module.eks.worker_iam_role_arn
}