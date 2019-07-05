variable "project" {
}

variable "zone" {
}

variable "region" {
}

variable "clusterid" {
}

variable "image_family" {
}

variable "temp_size" {
  default = "g1-small"
}

variable "public_range" {
}

variable "temp_disk_size" {
  default = "10"
}

variable "temp_disk_type" {
  default = "pd-standard"
}

variable "private_ssh_key" {
}

variable "google-cloud-repo" {
  default = "~/terraform-gce-openshift/modules/image/google-cloud.repo"
}

variable "eth-config" {
  default = "~/terraform-gce-openshift/modules/image/ifcfg-eth0"
}

variable "script-prep-image" {
  default = "~/terraform-gce-openshift/modules/image/script.sh"
}

variable "rhn_username" {
}

variable "rhn_password" {
}

variable "pool_id" {
}
