resource "random_password" "db" {
  length           = 24
  special          = true
  override_special = "!#$%*-_=+"
}

resource "google_service_account" "runtime" {
  account_id   = "${var.prefix}-cr-${var.environment}"
  display_name = "Cloud Run runtime (${var.environment})"
  project      = var.project_id
}

locals {
  db_connection_string = "postgresql://${var.db_user}:${random_password.db.result}@${module.database.private_ip_address}:5432/${var.db_name}?sslmode=require"
  runtime_sa_email     = google_service_account.runtime.email
}

module "network" {
  source                = "./modules/network"
  project_id            = var.project_id
  region                = var.region
  network_name          = var.network_name
  vpc_cidr              = var.vpc_cidr
  private_subnet_cidr   = var.private_subnet_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  connector_subnet_cidr = var.connector_subnet_cidr
  zones                 = var.zones
}

module "registry" {
  source             = "./modules/registry"
  project_id         = var.project_id
  region             = var.region
  repository_id      = var.artifact_registry_id
  cloud_run_sa_email = local.runtime_sa_email
}

module "database" {
  source                 = "./modules/database"
  project_id             = var.project_id
  region                 = var.region
  instance_name          = var.db_instance_name
  tier                   = var.db_tier
  database_name          = var.db_name
  db_user                = var.db_user
  db_password            = random_password.db.result
  network_id             = module.network.network_id
  private_vpc_connection = module.network.private_vpc_connection
}

module "secrets" {
  source           = "./modules/secrets"
  project_id       = var.project_id
  secret_id        = var.secret_id
  secret_payload   = local.db_connection_string
  accessor_members = ["serviceAccount:${local.runtime_sa_email}"]
}

module "compute" {
  source                   = "./modules/compute"
  project_id               = var.project_id
  region                   = var.region
  service_name             = var.cloud_run_service_name
  image                    = var.cloud_run_image
  min_instances            = var.cloud_run_min_instances
  max_instances            = var.cloud_run_max_instances
  vpc_connector_id         = module.network.vpc_connector_id
  secret_id                = module.secrets.secret_id
  runtime_service_account  = google_service_account.runtime.email
  database_connection_name = module.database.connection_name

  depends_on = [module.secrets, module.database, module.network]
}

module "monitoring" {
  count      = var.enable_monitoring_sink ? 1 : 0
  source     = "./modules/monitoring"
  project_id = var.project_id
  sink_name  = "${var.prefix}-audit-${var.environment}"
}
