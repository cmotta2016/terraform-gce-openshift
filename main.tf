// Create ssh key
resource "null_resource" "create_bastion_private_key" {
  provisioner "local-exec" {
    command = "if [ ! -f ${var.bastion_ssh_key_file} ]; then ssh-keygen -t rsa -f ${var.bastion_ssh_key_file} -C jeniffer_jc29 -N ''; fi"
  }
}

// Add metadata to all project
resource "google_compute_project_metadata_item" "ssh-key" {
  key = "sshKeys"
  value = "jeniffer_jc29:${file(var.bastion_ssh_publickey_file)}"
  project = "${var.project}"
  depends_on = ["null_resource.create_bastion_private_key"]
}

// This module deploy Network and Subnetwork
module "network" {
  source  = "./modules/network"
  project = "${var.project}"
  zone = "${var.zone}"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
}

// Module to create and prepare temp image
module "create_temp_image" {
  source = "./modules/image"
  project = "${var.project}"
  zone = "${var.zone}"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  image-family = "${var.image-family}"
  private_ssh_key = "${var.private_ssh_key}"
  rhn_username = "${var.rhn_username}"
  rhn_password = "${var.rhn_password}"
  pool_id = "${var.pool_id}"
//  temp_disk= "${module.create_temp_image.disk_name}"
}

// Module to create and prepare temp image
module "create_base_image" {
  source = "./modules/base_image"
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
  base_image = "${module.create_base_image.image_name}"
  rhn_username = "${var.rhn_username}"
  rhn_password = "${var.rhn_password}"
  pool_id = "${var.pool_id}"
}

// Module to deploy master node
module "master_node" {
  source = "./modules/nodes/master_node"
  project = "${var.project}"
  zone = "${var.zone}"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  subnetwork-name = "${module.network.subnetwork-name}"
  network-name = "${module.network.network-name}"
  base_image = "${module.create_base_image.image_name}"
}

// Module to deploy infra node
module "infra_node" {
  source = "./modules/nodes/infra_node"
  project = "${var.project}"
  zone = "${var.zone}"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  subnetwork-name = "${module.network.subnetwork-name}"
  network-name = "${module.network.network-name}"
  base_image = "${module.create_base_image.image_name}"
}

// Module to deploy apps node
module "app_node" {
  source = "./modules/nodes/app_node"
  project = "${var.project}"
  zone = "${var.zone}"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  subnetwork-name = "${module.network.subnetwork-name}"
  network-name = "${module.network.network-name}"
  base_image = "${module.create_base_image.image_name}"
}

// Module post install
module "remove_scripts" {
  source = "./modules/post_install"
  zone = "${var.zone}"
  master-name = "${module.master_node.master-name}"
  clusterid = "${var.clusterid}"
  infra-name = "${module.infra_node.infra-name}"
  bastion_ip = "${module.bastion_node.bastion_public_ip}"
}
