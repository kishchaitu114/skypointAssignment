resource "google_sql_database_instance" "postgres" {
  name             = var.instance_name
  project          = var.project_id
  database_version = "POSTGRES_15"
  region           = var.region

  settings {
    tier              = var.tier
    availability_type = "ZONAL"
    disk_autoresize   = true

    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = var.network_id
      enable_private_path_for_google_cloud_services = true
      ssl_mode                                      = "ENCRYPTED_ONLY"
    }

    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "off"
    }
  }

  depends_on = [var.private_vpc_connection]
}

resource "google_sql_database" "app" {
  name     = var.database_name
  instance = google_sql_database_instance.postgres.name
  project  = var.project_id
}

resource "google_sql_user" "app" {
  name     = var.db_user
  instance = google_sql_database_instance.postgres.name
  project  = var.project_id
  password = var.db_password
}
