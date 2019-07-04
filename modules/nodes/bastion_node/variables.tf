variable "project" {
}

variable "region" {
}

variable "zone" {
}

variable "clusterid" {
}

variable "bastion_size" {
  default = "g1-small"
}

variable "bastion_disk_size" {
  default = "15"
}

variable "bastion_disk_type" {
  default = "pd-standard"
}

//variable "base_image_family" {
//}

//variable "base_image_name" {
//}

variable "base_image" {
}

variable "subnetwork-name" {
}

variable "bastion_ssh_key_file" {
  default = "~/.ssh/tf-ssh-key"
}

variable "bastion_ssh_publickey_file" {
  default = "~/.ssh/tf-ssh-key.pub"
}

variable "private_ssh_key"{
  default     = "~/.ssh/tf-ssh-key"
}
