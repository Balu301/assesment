# terraform/variables.tf
variable "project_id" {
  description = "The project ID to host the cluster in."
  type        = string
}

variable "region" {
  description = "The region to host the cluster in."
  type        = string
  default     = "us-central1"
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
  default     = "gke-private-vpc"
}

variable "subnet_1_name" {
  description = "The name of the first private subnet."
  type        = string
  default     = "gke-private-subnet-1"
}

variable "subnet_1_cidr" {
  description = "The CIDR block for the first private subnet."
  type        = string
  default     = "10.10.10.0/24"
}

variable "subnet_2_name" {
  description = "The name of the second private subnet."
  type        = string
  default     = "gke-private-subnet-2"
}

variable "subnet_2_cidr" {
  description = "The CIDR block for the second private subnet."
  type        = string
  default     = "10.10.11.0/24"
}

variable "gke_cluster_name" {
  description = "The name for the GKE cluster."
  type        = string
  default     = "private-gke-cluster"
}

variable "gke_pods_ipv4_cidr_block" {
  description = "The secondary IPv4 range for pods in the GKE cluster."
  type        = string
  default     = "10.20.0.0/14"
}

variable "gke_services_ipv4_cidr_block" {
  description = "The secondary IPv4 range for services in the GKE cluster."
  type        = string
  default     = "10.30.0.0/20"
}

variable "master_authorized_networks_cidr" {
  description = "CIDR block for master authorized networks. This should be the CIDR of the network from where you will access the cluster."
  type        = string
}

variable "node_pool_name" {
  description = "The name of the GKE node pool."
  type        = string
  default     = "private-node-pool"
}

variable "node_count" {
  description = "The number of nodes in the node pool."
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "The machine type for the GKE nodes."
  type        = string
  default     = "e2-medium"
}