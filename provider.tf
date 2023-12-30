provider "google" {
  project     = var.gcp_project
  region      = var.gcp_region
}

terraform {
  backend "gcs" {
    bucket = var.tf_bucket_name
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

