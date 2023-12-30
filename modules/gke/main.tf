resource "google_project_service" "kubernetes" {
  project = var.project_id
  service = "container.googleapis.com"
}

resource "google_project_service" "cloud_resource_manager" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_container_cluster" "gke" {
  name                     = var.name
  location                 = var.location
  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count
  network                  = var.network
  subnetwork               = var.subnetwork
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = var.networking_mode

  # Optional, if you want multi-zonal cluster
  node_locations = [
    "${var.location}-b"
  ]

  addons_config {
    http_load_balancing {
      disabled = var.http_load_balancing
    }
    horizontal_pod_autoscaling {
      disabled = var.horizontal_pod_autoscaling
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }


  private_cluster_config {
    enable_private_nodes    = var.enable_private_nodes
    enable_private_endpoint = var.enable_private_endpoint
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  
  }
  

