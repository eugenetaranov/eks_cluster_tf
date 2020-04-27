output "iam_role_arn" {
  value = module.servicerole.this_iam_role_arn
}

output "name" {
  value = var.service_account_name
}
