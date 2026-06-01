resource "google_cloud_run_v2_service" "app" {
  name     = var.service_name
  project  = var.project_id
  location = var.region
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = var.runtime_service_account
    scaling {
      min_instance_count = var.min_instances
      max_instance_count = var.max_instances
    }

    vpc_access {
      connector = var.vpc_connector_id
      egress    = "PRIVATE_RANGES_ONLY"
    }

    containers {
      image = var.image
      ports {
        container_port = 8000
      }
      env {
        name = "DATABASE_URL"
        value_source {
          secret_key_ref {
            secret  = var.secret_id
            version = "latest"
          }
        }
      }
      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
      startup_probe {
        http_get {
          path = "/health"
          port = 8000
        }
        initial_delay_seconds = 5
        period_seconds        = 10
      }
      liveness_probe {
        http_get {
          path = "/health"
          port = 8000
        }
        period_seconds = 20
      }
    }
  }

}

resource "google_project_iam_member" "secret_accessor" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${var.runtime_service_account}"
}

resource "google_project_iam_member" "cloudsql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${var.runtime_service_account}"
}
