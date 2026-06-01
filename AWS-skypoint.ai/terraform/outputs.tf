output "ecr_repository_url" {
  value = module.registry.repository_url
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

output "app_irsa_role_arn" {
  value = module.eks.app_irsa_role_arn
}

output "rds_endpoint" {
  value = module.database.endpoint
}

output "database_connection_string" {
  value     = local.db_connection_string
  sensitive = true
}

output "secrets_manager_secret_arn" {
  value = module.secrets.secret_arn
}
