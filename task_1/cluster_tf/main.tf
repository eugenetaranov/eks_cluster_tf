module "eks" {
  source       = "github.com/terraform-aws-modules/terraform-aws-eks?ref=v11.1.0"
  cluster_name = var.cluster_name
  subnets      = var.private_subnets
  vpc_id       = var.vpc_id
  tags         = merge({ "Name" = var.cluster_name }, var.tags)

  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = var.node_group_settings["disk_size"]
  }

  node_groups = {
    main = {
      desired_capacity = var.node_group_settings["desired_capacity"]
      max_capacity     = var.node_group_settings["max_capacity"]
      min_capacity     = var.node_group_settings["min_capacity"]
      instance_type    = var.node_group_settings["instance_type"]

      k8s_labels = {
        Environment = "test-${var.region}"
      }
      additional_tags = var.tags
    }
  }

  enable_irsa = true
  map_roles = [
    {
      rolearn  = module.dev_role.arn
      username = "dev-user"
      groups   = ["system:basic-user"]
    },
    {
      rolearn  = module.admin_role.arn
      username = "admin-user"
      groups   = ["system:masters"]
    }
  ]
  cluster_enabled_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]
}

locals {
  public_subnets_merged  = join(" ", var.public_subnets)
  private_subnets_merged = join(" ", var.private_subnets)
}

resource "null_resource" "public_subnets_tags" {
  triggers = {
    cluster_id = module.eks.cluster_id
  }

  provisioner "local-exec" {
    command = "aws ec2 create-tags --resources ${local.public_subnets_merged} --tags Key=kubernetes.io/cluster/${module.eks.cluster_id},Value=shared Key=kubernetes.io/role/elb,Value=1"
  }
}

resource "null_resource" "private_subnets_tags" {
  triggers = {
    cluster_id = module.eks.cluster_id
  }

  provisioner "local-exec" {
    command = "aws ec2 create-tags --resources ${local.private_subnets_merged} --tags Key=kubernetes.io/cluster/${module.eks.cluster_id},Value=shared Key=kubernetes.io/role/internal-elb,Value=1"
  }
}

locals {
  oidc_provider_url = split("https://", module.eks.cluster_oidc_issuer_url)[1]
}