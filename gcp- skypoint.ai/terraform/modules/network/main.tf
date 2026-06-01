resource "google_compute_network" "vpc" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private" {
  name          = "${var.network_name}-private"
  project       = var.project_id
  region        = var.region
  ip_cidr_range = var.private_subnet_cidr
  network       = google_compute_network.vpc.id

  private_ip_google_access = true
}

resource "google_compute_subnetwork" "public" {
  name          = "${var.network_name}-public"
  project       = var.project_id
  region        = var.region
  ip_cidr_range = var.public_subnet_cidr
  network       = google_compute_network.vpc.id
}

# Dedicated /28 for Serverless VPC Access (Cloud Run → private Cloud SQL)
resource "google_compute_subnetwork" "connector" {
  name          = "${var.network_name}-connector"
  project       = var.project_id
  region        = var.region
  ip_cidr_range = var.connector_subnet_cidr
  network       = google_compute_network.vpc.id
}

resource "google_compute_global_address" "private_ip_alloc" {
  name          = "${var.network_name}-psa-range"
  project       = var.project_id
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

resource "google_vpc_access_connector" "connector" {
  name          = "${var.network_name}-cr-connector"
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = var.connector_subnet_cidr
  min_instances = 2
  max_instances = 3
  machine_type  = "e2-micro"

  depends_on = [google_service_networking_connection.private_vpc_connection]
}
