variable "project" {
}

variable "region" {
}

variable "zone" {
}

variable "clusterid" {
}

variable "app_size" {
  default = "g1-small"
}

variable "boot_disk_size" {
  default = "15"
}

variable "boot_disk_type" {
  default = "pd-standard"
}

variable "docker_disk_size" {
  default = "30"
}

variable "docker_disk_type" {
  default = "pd-standard"
}

variable "gfs_disk_size" {
  default = "30"
}

variable "gfs_disk_type" {
  default = "pd-standard"
}

variable "base_image_family" {
}

variable "base_image_name" {
}

variable "subnetwork-name" {
}

variable "number" {
 default = 3
}