

resource "google_container_node_pool" "node_pool" {
  name       = "${var.name}-node-group"
  cluster    = var.cluster_id
  node_count = var.node_count

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = var.machine_type #"e2-small"

  labels = var.labels


    service_account = var.sa_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "spot" {
  name    = "spot"
  cluster = var.cluster_id

  management {
    auto_repair  = var.auto_repair #true
    auto_upgrade = var.auto_upgrade #true
  }

  autoscaling {
    min_node_count = var.min_node_count #0
    max_node_count = var.max_node_count #10
  }

  node_config {
    preemptible  = true
    machine_type = var.machine_type

  labels = var.labels


    taint {
      key    = "instance_type"
      value  = "spot"
      effect = "NO_SCHEDULE"
    }

    service_account = var.sa_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}