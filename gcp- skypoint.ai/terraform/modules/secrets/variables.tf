variable "project_id" { type = string }
variable "secret_id" { type = string }
variable "secret_payload" {
  type      = string
  sensitive = true
}
variable "accessor_members" {
  type = list(string)
}
