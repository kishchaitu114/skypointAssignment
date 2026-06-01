project_id  = "your-gcp-project-id"
region      = "us-central1"
environment = "prod"
prefix      = "healthcare"

tfstate_bucket = "healthcare-tfstate-your-gcp-project-id"
tfstate_prefix = "healthcare/gcp/prod"

network_name          = "healthcare-vpc-prod"
vpc_cidr              = "10.31.0.0/16"
private_subnet_cidr   = "10.31.1.0/24"
public_subnet_cidr    = "10.31.2.0/24"
connector_subnet_cidr = "10.31.3.0/28"
zones                 = ["us-central1-a", "us-central1-b"]

artifact_registry_id   = "healthcare"
cloud_run_service_name = "healthcare-api-prod"
cloud_run_min_instances = 0
cloud_run_max_instances = 5

db_instance_name = "hc-pg-prod"
db_tier          = "db-custom-1-3840"
db_name          = "healthcare"
db_user          = "pgadmin"
secret_id        = "database-url-prod"

enable_monitoring_sink = true
