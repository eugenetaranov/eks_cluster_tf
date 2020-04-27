variable "role_name" {
  description = "Role name (IAM group, IAM role, Kubernetes user)"
  type        = string
}

variable "eks_cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "users" {
  description = "List of IAM users"
  type        = set(string)
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = null
}