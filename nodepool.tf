# terraform/nodepool.tf

resource "google_container_node_pool" "primary_nodes" {
  name       = var.node_pool_name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    # Nodes have no public IP addresses
    tags = ["gke-node", "${var.gke_cluster_name}"]

    # Using Workload Identity
    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    # Shielded node configuration
    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }

  # Spread nodes across zones in the region for high availability
  management {
    auto_repair  = true
    auto_upgrade = true
  }
}