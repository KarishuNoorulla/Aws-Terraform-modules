provider "aws" {
  region = var.region
  # profile = var.aws_profile   # optional
}

data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}
