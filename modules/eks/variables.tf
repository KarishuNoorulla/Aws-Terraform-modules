variable "project" { type = string }
variable "region"  { type = string }
variable "cluster_name" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "node_group_instance_types" { type = list(string) }
variable "node_group_desired_capacity" { type = number }
variable "node_group_min_size" { type = number }
variable "node_group_max_size" { type = number }
