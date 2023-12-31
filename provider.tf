provider "google" {
  project     = var.gcp_project
  region      = var.gcp_region
}

terraform {
  backend "gcs" { }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

