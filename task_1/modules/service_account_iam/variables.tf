variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = null
}

variable "service_account_name" {
  description = "Service account name"
  type        = string
}

variable "iam_policies" {
  description = "List of iam policies (ARN) to be attached to the service role"
  type        = set(string)
}

variable "service_account_namespace" {
  description = "Namespace service account to be attached to"
  type        = string
}

variable "oidc_provider_url" {
  description = "OIDC provider url"
  type        = string
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
}