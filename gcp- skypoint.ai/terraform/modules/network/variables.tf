variable "project_id" { type = string }
variable "region" { type = string }
variable "network_name" { type = string }
variable "vpc_cidr" { type = string }
variable "private_subnet_cidr" { type = string }
variable "public_subnet_cidr" { type = string }
variable "connector_subnet_cidr" { type = string }
variable "zones" { type = list(string) }
