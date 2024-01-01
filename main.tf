module "vpc" {
  source = "./modules/vpc"
  name = "${var.gcp_project}-vpc-${var.env}"
}

module "subnet" {
  source = "./modules/subnet"
  name = "${var.gcp_project}-subnet-${var.env}"
  nework_id = module.vpc.id
  region = var.gcp_region
  ip_cidr_range = var.subnet_ip_cidr_range
  depends_on = [ module.vpc ]
}

module "gke" {
  source = "./modules/gke"
  project_id = var.gcp_project
  name = var.gke_cluster_name
  location = var.gcp_region
  network   = module.vpc.self_link
  subnetwork = module.subnet.self_link
}

module "gke_nodegroup" {
  source = "./modules/gke_nodegroup"
  name = "${var.gcp_project}-gke-nodegroup-${var.env}"
  node_count = var.gke_nodegroup_node_count
  cluster_id =  module.gke.id
  labels = var.labels
  depends_on = [ module.gke ]
}

module "artifact_repo" {
  source = "./modules/artifact_repo"
  location = var.gcp_region
  name = "artifact-repo-${var.env}"
  labels = var.labels
}


module "router" {
  source = "./modules/router"
  name = "${var.gcp_project}-router-${var.env}"
  region = var.gcp_region
  network_id = module.vpc.id
  depends_on = [ module.vpc ]
}

module "nat" {
  source = "./modules/nat"
  name = "${var.gcp_project}-nat-${var.env}"
  router_name = module.router.name
  region      = var.gcp_region
  subnet_id = module.subnet.id
  depends_on = [ module.router, module.subnet ]


}

