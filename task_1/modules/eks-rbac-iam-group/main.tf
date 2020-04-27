data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "default" {
  name = var.eks_cluster_name
}

resource "aws_iam_group" "default" {
  name = "eks-role-${var.eks_cluster_name}-${var.role_name}"
}

resource "aws_iam_group_membership" "dev" {
  group = aws_iam_group.default.id
  name  = "eks-role-${var.eks_cluster_name}-${var.role_name}"
  users = var.users
}

resource "aws_iam_group_policy" "default" {
  name   = "eks-policy-${var.eks_cluster_name}-${var.role_name}"
  group  = aws_iam_group.default.id
  policy = data.aws_iam_policy_document.default_policy.json
}

data "aws_iam_policy_document" "default_policy" {
  statement {
    actions   = ["eks:ListClusters"]
    resources = ["*"]
  }

  statement {
    actions   = ["eks:DescribeCluster"]
    resources = [data.aws_eks_cluster.default.arn]
  }

  statement {
    actions   = ["sts:AssumeRole"]
    resources = [aws_iam_role.default.arn]
  }
}

resource "aws_iam_role" "default" {
  name               = "eks-role-${var.eks_cluster_name}-${var.role_name}"
  assume_role_policy = data.aws_iam_policy_document.default_assume_role.json
  tags               = var.tags
}

data "aws_iam_policy_document" "default_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}