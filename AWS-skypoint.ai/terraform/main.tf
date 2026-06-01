resource "random_password" "db" {
  length           = 24
  special          = true
  override_special = "!#$%*-_=+"
}

locals {
  db_connection_string = "postgresql://${var.db_username}:${random_password.db.result}@${module.database.endpoint}:5432/${var.db_name}?sslmode=require"
  name_prefix          = "${var.prefix}-${var.environment}"
}

module "network" {
  source               = "./modules/network"
  prefix               = local.name_prefix
  region               = var.region
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
}

module "registry" {
  source          = "./modules/registry"
  repository_name = var.ecr_repository_name
  scan_on_push    = true
}

module "database" {
  source              = "./modules/database"
  identifier          = var.db_identifier
  subnet_ids          = module.network.private_subnet_ids
  vpc_security_groups = [module.network.rds_security_group_id]
  instance_class      = var.db_instance_class
  allocated_storage   = var.db_allocated_storage
  db_name             = var.db_name
  username            = var.db_username
  password            = random_password.db.result
}

module "secrets" {
  source       = "./modules/secrets"
  secret_name  = var.secrets_manager_secret_name
  secret_value = local.db_connection_string
  tags = {
    Environment = var.environment
  }
}

module "eks" {
  source               = "./modules/eks"
  cluster_name         = var.eks_cluster_name
  cluster_version      = var.eks_cluster_version
  vpc_id               = module.network.vpc_id
  private_subnet_ids   = module.network.private_subnet_ids
  node_instance_types  = var.eks_node_instance_types
  node_desired_size    = var.eks_node_desired_size
  node_min_size        = var.eks_node_min_size
  node_max_size        = var.eks_node_max_size
  region               = var.region
  secrets_secret_arn   = module.secrets.secret_arn
  ecr_repository_arn   = module.registry.repository_arn
}

module "monitoring" {
  count      = var.enable_cloudwatch_alarms ? 1 : 0
  source     = "./modules/monitoring"
  alarm_name = "${local.name_prefix}-eks-cpu-high"
}
