variable "project" {
}

variable "region" {
}

variable "zone" {
}

variable "clusterid" {
}

variable "master_size" {
  default = "g1-small"
}

variable "boot_disk_size" {
  default = "15"
}

variable "docker_disk_size" {
  default = "30"
}

variable "boot_disk_type" {
  default = "pd-standard"
}

variable "docker_disk_type" {
  default = "pd-standard"
}

variable "subnetwork-name" {
}

variable "base_image" {
}
