variable "region" {
  description = "AWS region"
  type        = string
}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "private_subnets" {
  description = "VPC private subnets"
  type        = set(string)
}

variable "public_subnets" {
  description = "VPC public subnets"
  type        = set(string)
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = null
}

variable "node_group_settings" {
  description = "Cluster node group settings"
  type        = map(string)
  default = {
    desired_capacity = 1
    max_capacity     = 1
    min_capacity     = 1
    instance_type    = "t3.small"
    disk_size        = 20
  }
}

variable "dev_users" {
  description = "List of developers with limitied access to specific namespaces in the EKS cluster"
  type        = set(string)
}

variable "admin_users" {
  description = "List of admin users with full access to the EKS cluster"
  type        = set(string)
}