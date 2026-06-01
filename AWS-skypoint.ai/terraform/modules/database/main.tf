resource "aws_db_subnet_group" "main" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = var.identifier
  }
}

resource "aws_db_instance" "postgres" {
  identifier             = var.identifier
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = var.vpc_security_groups

  publicly_accessible          = false
  storage_encrypted            = true
  deletion_protection          = false
  skip_final_snapshot          = true
  backup_retention_period      = 7
  auto_minor_version_upgrade   = true
  parameter_group_name         = aws_db_parameter_group.ssl.name
  apply_immediately            = true
}

resource "aws_db_parameter_group" "ssl" {
  name   = "${var.identifier}-pg15-ssl"
  family = "postgres15"

  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }
}
