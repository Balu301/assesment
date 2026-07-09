# terraform/outputs.tf

output "cluster_name" {
  description = "The name of the GKE cluster."
  value       = google_container_cluster.primary.name
}

output "cluster_private_endpoint" {
  description = "The private endpoint of the GKE cluster's control plane."
  value       = google_container_cluster.primary.private_cluster_config[0].private_endpoint
}

output "cluster_public_endpoint" {
  description = "The public endpoint of the GKE cluster's control plane (should be empty)."
  value       = google_container_cluster.primary.private_cluster_config[0].public_endpoint
}