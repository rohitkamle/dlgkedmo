module "vpc" {
  source = "./modules/gcp/vpc"
  name = "${var.gcp_project}-vpc-${var.env}"
}

module "subnet" {
  source = "./modules/gcp/subnet"
  name = "${var.gcp_project}-subnet-${var.env}"
  nework_id = module.vpc.id
  region = var.gcp_region
  ip_cidr_range = var.subnet_ip_cidr_range
  depends_on = [ module.vpc ]
}


module "sa" {
  source = "./modules/gcp/sa"
  name = var.gke_cluster_name
}


module "project_iam_binding" {
  source = "./modules/gcp/project_iam_binding"
  for_each = toset(var.gke_node_group_sa_roles)
  project_id = var.gcp_project
  role = var.each.value
  member_email = module.sa.email
}

module "gke" {
  source = "./modules/gcp/gke"
  project_id = var.gcp_project
  name = var.gke_cluster_name
  location = var.gcp_region
  network   = module.vpc.self_link
  subnetwork = module.subnet.self_link
}


module "gke_nodegroup" {
  source = "./modules/gcp/gke_nodegroup"
  name = var.gke_cluster_name
  node_count = var.gke_nodegroup_node_count
  cluster_id =  module.gke.id
  labels = var.labels
  sa_email = module.sa.email
  depends_on = [ module.gke ]
}

module "artifact_repo" {
  source = "./modules/gcp/artifact_repo"
  location = var.gcp_region
  name = "artifact-repo-${var.env}"
  labels = var.labels
}


module "router" {
  source = "./modules/gcp/router"
  name = "${var.gcp_project}-router-${var.env}"
  region = var.gcp_region
  network_id = module.vpc.id
  depends_on = [ module.vpc ]
}

module "nat" {
  source = "./modules/gcp/nat"
  name = "${var.gcp_project}-nat-${var.env}"
  router_name = module.router.name
  region      = var.gcp_region
  subnet_id = module.subnet.id
  depends_on = [ module.router, module.subnet ]


}

