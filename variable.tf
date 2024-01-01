variable "gcp_project" {
  description = "Unique Project name"
  type        = string
}


variable "gcp_region" {
  description = "Unique Project name"
  type        = string
}



variable "env" {
  description = "provide Envirorment Name"
  type        = string
  default     = "dev"
}


variable "gke_cluster_name" {
  description = "GKE Cluster Name"
  type        = string
}


variable "subnet_ip_cidr_range" {
  description = "Unique Project name"
  type        = string
}

variable "gke_nodegroup_node_count" {
  description = "Unique Project name"
  type        = number
}

variable "gke_node_group_sa_roles" {
  description = "Unique Project name"
  type    = list(string)

}



variable "labels" {
  description = "Labels for the instance"
  type        = map(string)
}




