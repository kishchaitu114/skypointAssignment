project_id  = "your-gcp-project-id"
region      = "us-central1"
environment = "dev"
prefix      = "healthcare"

tfstate_bucket = "healthcare-tfstate-your-gcp-project-id"
tfstate_prefix = "healthcare/gcp/dev"

network_name          = "healthcare-vpc-dev"
vpc_cidr              = "10.30.0.0/16"
private_subnet_cidr   = "10.30.1.0/24"
public_subnet_cidr    = "10.30.2.0/24"
connector_subnet_cidr = "10.30.3.0/28"
zones                 = ["us-central1-a", "us-central1-b"]

artifact_registry_id   = "healthcare"
cloud_run_service_name = "healthcare-api-dev"
cloud_run_min_instances = 0
cloud_run_max_instances = 5

db_instance_name = "hc-pg-dev"
db_tier          = "db-f1-micro"
db_name          = "healthcare"
db_user          = "pgadmin"
secret_id        = "database-url-dev"

enable_monitoring_sink = true
