resource "aws_iam_role_policy_attachment" "cloudwatch_monitoring" {
  role       = module.eks.worker_iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "kubectl_manifest" "fluentd_monitoring" {
  yaml_body = replace(replace(file("templates/fluentd-monitoring.yaml"), "_CLUSTER_NAME_", module.eks.cluster_id), "_AWS_REGION_", var.region)
}