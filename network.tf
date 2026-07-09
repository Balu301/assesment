# terraform/network.tf

# Create a custom VPC
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Create the first private subnet
resource "google_compute_subnetwork" "subnet_1" {
  name          = var.subnet_1_name
  ip_cidr_range = var.subnet_1_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = var.gke_pods_ipv4_cidr_block
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = var.gke_services_ipv4_cidr_block
  }
}

# Create the second private subnet
resource "google_compute_subnetwork" "subnet_2" {
  name          = var.subnet_2_name
  ip_cidr_range = var.subnet_2_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  private_ip_google_access = true
}

# Firewall rule to allow internal traffic within the VPC
resource "google_compute_firewall" "allow_internal" {
  name    = "${var.vpc_name}-allow-internal"
  network = google_compute_network.vpc.name
  allow {
    protocol = "all"
  }
  source_ranges = [
    var.subnet_1_cidr,
    var.subnet_2_cidr,
    var.gke_pods_ipv4_cidr_block,
    var.gke_services_ipv4_cidr_block
  ]
}