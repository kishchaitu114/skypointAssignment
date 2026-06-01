variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "Primary region (e.g. us-central1)"
}

variable "environment" {
  type        = string
  description = "Environment label: dev | prod"
}

variable "prefix" {
  type        = string
  description = "Resource name prefix"
}

# Backend (passed via -backend-config at init; documented in tfvars for operators)
variable "tfstate_bucket" {
  type        = string
  description = "GCS bucket for Terraform remote state"
}

variable "tfstate_prefix" {
  type        = string
  description = "State object prefix inside the bucket"
}

variable "network_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "connector_subnet_cidr" {
  type = string
}

variable "zones" {
  type        = list(string)
  description = "Two zones for HA subnets"
}

variable "artifact_registry_id" {
  type = string
}

variable "cloud_run_service_name" {
  type = string
}

variable "cloud_run_image" {
  type        = string
  description = "Container image URI (set by CI after first push; placeholder for plan)"
  default     = "us-docker.pkg.dev/placeholder/healthcare/healthcare-app:latest"
}

variable "cloud_run_min_instances" {
  type    = number
  default = 0
}

variable "cloud_run_max_instances" {
  type    = number
  default = 5
}

variable "db_instance_name" {
  type = string
}

variable "db_tier" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "secret_id" {
  type        = string
  description = "Secret Manager secret id for database connection string"
}

variable "enable_monitoring_sink" {
  type    = bool
  default = true
}
