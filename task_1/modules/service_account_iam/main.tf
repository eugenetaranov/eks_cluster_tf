module "servicerole" {
  source           = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version          = "~> 2.0"
  role_name        = "${var.eks_cluster_name}-${var.service_account_namespace}-service-account"
  provider_url     = var.oidc_provider_url
  create_role      = true
  role_policy_arns = var.iam_policies
  tags             = var.tags
}

resource "kubernetes_service_account" "testservice" {
  metadata {
    name      = var.service_account_name
    namespace = var.service_account_namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = module.servicerole.this_iam_role_arn
    }
  }

  automount_service_account_token = true
}
