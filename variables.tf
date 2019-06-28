variable "project" {
  default = "terraform-project-244918"
}

variable "region" {
  default = "southamerica-east1"
}

variable "zone" {
  default = "southamerica-east1-b"
}

variable "clusterid" {
  default = "terraform-project"
}

variable "bastion_size" {
  default = "g1-small"
}

variable "bastion_disk_size" {
  default = "20GB"
}

variable "base_image" {
  default = "debian-cloud/debian-9"
}

variable "bastion_ssh_key_file" {
  default = ".bastionkey_id_rsa"
}
