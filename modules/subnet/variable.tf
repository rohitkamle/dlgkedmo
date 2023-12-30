variable "name" {
  description = "Name of the subnet"
  type        = string
}


variable "ip_cidr_range" {
  description = "ip_cidr_range for the Subnet"
   type        = string
}


variable "region" {
  description = "region for the subnet"
   type        = string
}

variable "nework_id" {
  description = "nework_id for the subnet"
   type        = string
}

variable "private_ip_google_access" {
  description = "private_ip_google_access for the subnet"
   type        = bool
   default     = true
}

