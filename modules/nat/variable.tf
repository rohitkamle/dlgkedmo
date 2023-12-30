variable "name" {
  description = "google compute router nat"
  type        = string
}

variable "region" {
  description = "google coregion "
  type        = string
}


variable "router_name" {
  description = "router name "
  type        = string
}

variable "subnet_id" {
  description = "subnet id "
  type        = string
}

variable "address_type" {
  description = "address_type name "
  type        = string
  default     = "EXTERNAL"
}

variable "network_tier" {
  description = "network_tier name"
  type        = string
  default     = "PREMIUM"
}

