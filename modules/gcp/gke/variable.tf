variable "project_id" {
  description = "project_id of for enabling container api"
  type        = string
}

variable "name" {
  description = "Name of GKE Cluster"
  type        = string
}

variable "location" {
  description = "Location of GKE Cluster"
  type        = string
}

variable "remove_default_node_pool" {
  description = "remove default node ool of GKE Cluster"
  type        = bool
  default     = true
}


variable "initial_node_count" {
  description = "Initial node code of GKE Cluster"
  type        = number
  default     = 1
}

variable "network" {
  description = "VPC name for GKE Cluster"
  type        = string

}

variable "subnetwork" {
  description = "subnet name for  GKE Cluster"
  type        = string
}


variable "networking_mode" {
  description = "networking mode of GKE Cluster"
  type        = string
  default     = "VPC_NATIVE"
}



variable "http_load_balancing" {
  description = "http load balancing of GKE Cluster"
  type        = bool
  default     = true
}

variable "horizontal_pod_autoscaling" {
  description = "horizontal pod autoscaling for GKE Cluster"
  type        = bool
  default     = true
}

variable "enable_private_nodes" {
  description = "enable private nodes for GKE Cluster"
  type        = bool
  default     = true
}


variable "enable_private_endpoint" {
  description = "enable private endpoint for GKE Cluster"
  type        = bool
  default     = false
}

variable "master_ipv4_cidr_block" {
  description = "master_ipv4_cidr_block for GKE Cluster"
  type        = string
  default     = "172.16.0.0/28"
}

