output "gke_name" {
  value = module.gke.name
}

output "gke_nodegroup_name" {
  value = module.gke_nodegroup.name
}

output "artifact_repo_url" {
  value = module.artifact_repo.repository_url
}

