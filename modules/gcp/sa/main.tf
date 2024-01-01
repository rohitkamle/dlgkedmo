
resource "google_service_account" "sa" {
  account_id = "${var.name}-sa"
}

