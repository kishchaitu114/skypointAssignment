output "artifact_registry_repository" {
  description = "Artifact Registry repository resource name"
  value       = module.registry.repository_id
}

output "cloud_run_uri" {
  description = "Cloud Run service URI (internal ingress when private)"
  value       = module.compute.service_uri
}

output "cloud_sql_connection_name" {
  description = "Cloud SQL instance connection name"
  value       = module.database.connection_name
}

output "database_connection_string" {
  description = "PostgreSQL connection string (sensitive)"
  value       = local.db_connection_string
  sensitive   = true
}

output "vpc_connector_id" {
  value = module.network.vpc_connector_id
}

output "runtime_service_account_email" {
  value = module.compute.runtime_service_account_email
}
