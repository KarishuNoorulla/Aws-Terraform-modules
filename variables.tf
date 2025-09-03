variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "Optional AWS CLI profile name"
  type        = string
  default     = ""
}

variable "project" {
  description = "Project name used for resource naming"
  type        = string
  default     = "demo-eks"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs (one per AZ)"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs (one per AZ)"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "private-eks-cluster"
}

variable "node_group_instance_types" {
  description = "Instance types for managed node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_group_desired_capacity" {
  type    = number
  default = 2
}

variable "node_group_min_size" {
  type    = number
  default = 1
}

variable "node_group_max_size" {
  type    = number
  default = 3
}
variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_password" {
  type    = string
  sensitive = true
}
