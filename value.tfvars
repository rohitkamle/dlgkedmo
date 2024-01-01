gcp_project = "fabled-era-408608"
gcp_region = "europe-west1"
subnet_ip_cidr_range = "10.0.0.0/18"
gke_nodegroup_node_count = 2
gke_node_group_sa_roles = {
"roles/artifactregistry.reader"
}

labels = {
  team       = "dataloop"
  environment = "dev"
  app        = "kubernetes"
}

