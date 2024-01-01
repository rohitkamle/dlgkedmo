

# Create a firewall rule for external access to Nginx on ports 80 and 443

resource "google_compute_firewall" "allow-nginx-external" {
  name    = "allow-nginx-external"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["nginx-controller"]

  priority = 1001
}