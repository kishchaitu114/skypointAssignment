variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "prefix" {
  type = string
}

variable "tfstate_bucket" {
  type        = string
  description = "Documented for operators; passed via -backend-config at init"
}

variable "tfstate_key" {
  type = string
}

variable "tfstate_dynamodb_table" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "ecr_repository_name" {
  type = string
}

variable "db_identifier" {
  type = string
}

variable "db_instance_class" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_allocated_storage" {
  type = number
}

variable "secrets_manager_secret_name" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

variable "eks_cluster_version" {
  type    = string
  default = "1.29"
}

variable "eks_node_instance_types" {
  type = list(string)
}

variable "eks_node_desired_size" {
  type = number
}

variable "eks_node_min_size" {
  type = number
}

variable "eks_node_max_size" {
  type = number
}

variable "enable_cloudwatch_alarms" {
  type    = bool
  default = true
}
