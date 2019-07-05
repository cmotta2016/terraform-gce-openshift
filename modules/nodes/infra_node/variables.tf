variable "project" {
}

variable "region" {
}

variable "zone" {
}

variable "clusterid" {
}

variable "infra_size" {
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

variable "private_ssh_key"{
  default     = "~/.ssh/tf-ssh-key"
}

variable "private_ranges" {
 default = "10.240.0.0/24"
}

variable "public_ranges" {
 default = "0.0.0.0/0"
}

variable "network-name" {
}
