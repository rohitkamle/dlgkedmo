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


variable "labels" {
  description = "Labels for the instance"
  type        = map(string)
}
