output "service_uri" {
  value = google_cloud_run_v2_service.app.uri
}

output "runtime_service_account_email" {
  value = var.runtime_service_account
}
