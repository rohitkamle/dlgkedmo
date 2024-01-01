variable "name" {
  description = "name for the vpc"
  type        = string
}

variable "routing_mode" {
  description = "routing_mode for the vpc"
  type        = string
  default     = "REGIONAL"
}
variable "auto_create_subnetworks" {
  description = "auto_create_subnetworks for the vpc"
  type        = bool
  default     = false
}
variable "mtu" {
  description = "mtu for the vpc"
  type        = number
  default     = 1460
}
variable "delete_default_routes_on_create" {
  description = "delete_default_routes_on_create for the vpc"
  type        = bool
  default     = false
}




