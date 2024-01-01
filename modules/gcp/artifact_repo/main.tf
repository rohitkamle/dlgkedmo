resource "google_artifact_registry_repository" "artifact_repo" {
  location      = var.location
  repository_id = var.name
  description   = "Artifact repository to store the customer docker images"
  format        = var.format
  labels        = var.labels

  }