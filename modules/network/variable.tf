variable "project" {
}

variable "region" {
}

variable "zone" {
}

variable "clusterid" {
}

variable "private_ranges" {
 default = "10.240.0.0/24"
}

variable "public_ranges" {
 default = "0.0.0.0/0"
}
