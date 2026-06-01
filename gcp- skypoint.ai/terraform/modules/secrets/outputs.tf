output "secret_id" {
  value = google_secret_manager_secret.db.secret_id
}

output "secret_name" {
  value = google_secret_manager_secret.db.name
}
