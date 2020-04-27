region = "us-east-1"
vpc_id = "vpc-03f42504e3c9a428b"
private_subnets = [
  "subnet-006e9f3fae8876a03",
  "subnet-01c30840fa1fb32fe",
  "subnet-02ac533e0819c05b4",
]
public_subnets = [
  "subnet-0187a32d2b4aa8956",
  "subnet-01147e9b92bf4ab15",
  "subnet-002313f69127f3263",
]
tags = {
  Terraform = true
}
cluster_name = "eks-1"
node_group_settings = {
  desired_capacity = 1
  max_capacity     = 4
  min_capacity     = 1
  instance_type    = "t3.small"
  disk_size        = 20
}

admin_users = [
  "testuseradmin",
]

dev_users = [
  "testuserdev",
]