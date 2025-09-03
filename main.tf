module "vpc" {
  source = "./modules/vpc"
  project = var.project
  region  = var.region
  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "eks" {
  source = "./modules/eks"
  project = var.project
  region = var.region
  cluster_name = var.cluster_name

  private_subnet_ids = module.vpc.private_subnets

  node_group_instance_types = var.node_group_instance_types
  node_group_desired_capacity = var.node_group_desired_capacity
  node_group_min_size = var.node_group_min_size
  node_group_max_size = var.node_group_max_size
}


module "bastion" {
  source           = "./modules/bastion"
  project          = var.project
  public_subnet_id = module.vpc.public_subnet_ids[0] # pick first public subnet
}



module "rds" {
  source                = "./modules/rds"
  project               = var.project
  private_subnet_ids    = module.vpc.private_subnet_ids
  rds_security_group_id = aws_security_group.rds_sg.id
  db_username           = var.db_username
  db_password           = var.db_password
}
resource "aws_security_group" "rds_sg" {
  name        = "${var.project}-rds-sg"
  description = "Allow MySQL from EKS"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [module.eks.cluster_security_group_id] # ✅ now valid
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-rds-sg"
  }
}
