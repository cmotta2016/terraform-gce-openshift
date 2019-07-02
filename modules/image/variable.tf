variable "project" {
}

variable "zone" {
}

variable "region" {
}

variable "clusterid" {
}

variable "image-family" {
}

variable "network-name" {
}

variable "temp_size" {
  default = "g1-small"
}

variable "public_ranges" {
 default = "0.0.0.0/0"
}

variable "temp_disk_size" {
  default = "10"
}

variable "temp_disk_type" {
  default = "pd-standard"
}
