variable "name" {
  description = "name id of the gke nodes"
   type        = string
}


variable "cluster_id" {
  description = "Cluster id of the gke cluster"
   type        = string
}

variable "node_count" {
  description = "Cluster id of the gke node"
   type        = number
   default     = 1
}

variable "sa_email" {
  description = "Service Account for Node Group"
   type        = string

}


variable "machine_type" {
  description = "machine_type id of the gke nodes"
   type        = string
   default     = "e2-small"
}


variable "auto_repair" {
  description = "auto_upgrade id of the gke cluster node"
   type        = bool
   default     = true
}


variable "auto_upgrade" {
  description = "auto_upgrade id of the gke cluster nodes"
   type        = bool
   default     = true
}


variable "min_node_count" {
  description = "min_node_count id of the gke nodes"
   type        = number
   default     = 1
}


variable "max_node_count" {
  description = "max_node_count id of the gke nodes"
   type        = number
   default     = 10
}


variable "labels" {
  description = "Labels for the instance"
  type        = map(string)
}
