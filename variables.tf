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

variable "image-family" {
  default = "rhel"
}

variable "cat_key_file" {
  default = "cat ~/.ssh/tf-ssh-key.pub"
}

variable "private_ssh_key"{
  default     = "~/.ssh/tf-ssh-key"
}
