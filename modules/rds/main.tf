resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.project}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project}-rds-subnet-group"
  }
}

resource "aws_db_instance" "wordpress_rds" {
  identifier              = "${var.project}-wordpress-db"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp2"
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [var.rds_security_group_id]

  username                = var.db_username
  password                = var.db_password
  port                    = 3306

  skip_final_snapshot     = true

  tags = {
    Name = "${var.project}-wordpress-db"
  }
}
