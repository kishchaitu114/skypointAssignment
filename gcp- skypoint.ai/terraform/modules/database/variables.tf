variable "project_id" { type = string }
variable "region" { type = string }
variable "instance_name" { type = string }
variable "tier" { type = string }
variable "database_name" { type = string }
variable "db_user" { type = string }
variable "db_password" {
  type      = string
  sensitive = true
}
variable "network_id" { type = string }

variable "private_vpc_connection" {
  description = "Service networking connection dependency"
}
