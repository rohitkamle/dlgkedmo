resource "google_project_iam_binding" "artifact_registry_reader_binding" {
  project = var._project_id
  role    = var.role

  members = [
    "serviceAccount:${var.member_email}",
  ]
}