variable "project_id" {
  description = "project_id of for enabling container api"
  type        = string
}

variable "name" {
  description = "Name of Artifcate Registry"
  type        = string
}

variable "location" {
  description = "Location of Artifcate Registry"
  type        = string
}


variable "format" {
  description = "Format of Artifcate Registry"
  type        = string
  default     = "DOCKER"
}



