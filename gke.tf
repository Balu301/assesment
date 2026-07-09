# terraform/gke.tf

resource "google_container_cluster" "primary" {
  name     = var.gke_cluster_name
  location = var.region
  network  = google_compute_network.vpc.id
  subnetwork = google_compute_subnetwork.subnet_1.id

  # Remove the default node pool
  remove_default_node_pool = true
  initial_node_count       = 1

  # Enable private cluster settings
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  # Restrict access to the control plane
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.master_authorized_networks_cidr
      display_name = "Management-Network"
    }
  }

  # Enable Workload Identity
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # IP allocation for pods and services
  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.subnet_1.secondary_ip_range[0].range_name
    services_secondary_range_name = google_compute_subnetwork.subnet_1.secondary_ip_range[1].range_name
  }

  # Recommended security settings
  enable_shielded_nodes = true
}