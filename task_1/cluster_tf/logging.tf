resource "aws_iam_role_policy_attachment" "logging" {
  policy_arn = aws_iam_policy.logging.arn
  role       = module.eks.worker_iam_role_name
}

resource "aws_iam_policy" "logging" {
  name_prefix = "logging-"
  description = "EKS logging policy for cluster ${module.eks.cluster_id}"
  policy      = data.aws_iam_policy_document.logging.json
}

data "aws_iam_policy_document" "logging" {
  statement {
    actions = [
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "kubectl_manifest" "fluentd_logging" {
  yaml_body = replace(replace(file("templates/fluentd-logging.yaml"), "_CLUSTER_NAME_", module.eks.cluster_id), "_AWS_REGION_", var.region)
}