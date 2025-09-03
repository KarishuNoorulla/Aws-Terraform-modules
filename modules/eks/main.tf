locals {
  cluster_name = var.cluster_name
}

resource "aws_eks_cluster" "this" {
  name     = local.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = var.private_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator"]
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy
  ]
}

resource "aws_eks_node_group" "managed_nodes" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${local.cluster_name}-ng"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = var.private_subnet_ids

  scaling_config {
    desired_size = var.node_group_desired_capacity
    min_size     = var.node_group_min_size
    max_size     = var.node_group_max_size
  }

  instance_types = var.node_group_instance_types
  force_update_version = true

  lifecycle {
    create_before_destroy = true
  }
}
