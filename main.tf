// Add metadata to all project
resource "google_compute_project_metadata_item" "ssh-key" {
  key = "sshKey"
  value = "jeniffer_jc29:${var.cat_key_file}"
  project = "${var.project}"
}

// This module deploy Network and Subnetwork
module "network" {
  source  = "./modules/network"
  project = "${var.project}"
}

// Module to create custom image
module "create_image" {
  source = "./modules/image"
  project = "${var.project}"
  zone = "${var.zone}"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  image-family = "${var.image-family}"
}

// Module to deploy bastion node
module "bastion_node" {
  source = "./modules/nodes/bastion_node"
  project = "${var.project}"
  zone = "${var.zone}"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  subnetwork-name = "${module.network.subnetwork-name}"
  base_image_family = "${module.create_image.image-family}"
  base_image_name = "${module.create_image.image-name}"
}

// Module to deploy master node
module "master_node" {
  source = "./modules/nodes/master_node"
  project = "${var.project}"
  zone = "${var.zone}"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  subnetwork-name = "${module.network.subnetwork-name}"
  base_image_family = "${module.create_image.image-family}"
  base_image_name = "${module.create_image.image-name}"
}

// Module to deploy infra node
module "infra_node" {
  source = "./modules/nodes/infra_node"
  project = "${var.project}"
  zone = "${var.zone}"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  subnetwork-name = "${module.network.subnetwork-name}"
  base_image_family = "${module.create_image.image-family}"
  base_image_name = "${module.create_image.image-name}"
}

// Module to deploy apps node
module "app_node" {
  source = "./modules/nodes/app_node"
  project = "${var.project}"
  zone = "${var.zone}"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  subnetwork-name = "${module.network.subnetwork-name}"
  base_image_family = "${module.create_image.image-family}"
  base_image_name = "${module.create_image.image-name}"
}
