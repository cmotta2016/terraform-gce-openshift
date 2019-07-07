// Create ssh key
resource "null_resource" "create_ssh_key" {
  provisioner "local-exec" {
    command = "if [ ! -f ${var.private_ssh_key} ]; then ssh-keygen -t rsa -f ${var.private_ssh_key} -C ${var.google_user} -N ''; fi"
  }
}

// Add metadata to all project
resource "google_compute_project_metadata_item" "ssh-key" {
  key = "sshKeys"
  value = "${var.google_user}:${file(var.public_ssh_key)}"
  project = "${var.project}"
  depends_on = ["null_resource.create_ssh_key"]
}

// This module deploy Network and Subnetwork
module "network" {
  source  = "./modules/network"
  project = "${var.project}"
  zone = "${var.zone}"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  private_range = "${var.private_range}"
  public_range = "${var.public_range}"
  managed-zone-name = "${var.managed-zone-name}"
  domain = "${var.domain}"
}

// Module to create and prepare temp image
module "create_temp_image" {
  source = "./modules/image"
  project = "${var.project}"
  zone = "${var.zone}"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  image_family = "${var.image_family}"
  private_ssh_key = "${var.private_ssh_key}"
  public_range = "${var.public_range}"
  rhn_username = "${var.rhn_username}"
  rhn_password = "${var.rhn_password}"
  pool_id = "${var.pool_id}"
}

// Module to create and prepare temp image
module "create_base_image" {
  source = "./modules/base_image"
  project = "${var.project}"
  zone = "${var.zone}"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  image_family = "${var.image_family}"
}

// Module to deploy bastion node
module "bastion_node" {
  source = "./modules/nodes/bastion_node"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  bastion_instance_size = "${var.bastion_instance_size}"
  bastion_disk_size = "${var.bastion_disk_size}"
  bastion_disk_type = "${var.bastion_disk_type}"
  private_ssh_key = "${var.private_ssh_key}"
  network_name = "${module.network.network_name}"
  subnetwork_name = "${module.network.subnetwork_name}"
  bastion_public_ip = "${module.network.bastion_public_ip}"
  base_image = "${module.create_base_image.image_name}"
  rhn_username = "${var.rhn_username}"
  rhn_password = "${var.rhn_password}"
  pool_id = "${var.pool_id}"
}

// Module to deploy master node
module "master_node" {
  source = "./modules/nodes/master_node"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  master_instance_size = "${var.master_instance_size}"
  boot_disk_size = "${var.boot_disk_size}"
  boot_disk_type = "${var.boot_disk_type}"
  docker_disk_size = "${var.docker_disk_size}"
  docker_disk_type = "${var.docker_disk_type}"
  network_name = "${module.network.network_name}"
  subnetwork_name = "${module.network.subnetwork_name}"
  master_public_ip = "${module.network.master_public_ip}"
  base_image = "${module.create_base_image.image_name}"
}

// Module to deploy infra node
module "infra_node" {
  source = "./modules/nodes/infra_node"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  infra_instance_size = "${var.infra_instance_size}"
  boot_disk_size = "${var.boot_disk_size}"
  boot_disk_type = "${var.boot_disk_type}"
  docker_disk_size = "${var.docker_disk_size}"
  docker_disk_type = "${var.docker_disk_type}"
  infra_public_ip = "${module.network.infra_public_ip}"
  network_name = "${module.network.network_name}"
  subnetwork_name = "${module.network.subnetwork_name}"
  base_image = "${module.create_base_image.image_name}"
}

// Module to deploy apps node
module "app_node" {
  source = "./modules/nodes/app_node"
  region = "${var.region}"
  clusterid = "${var.clusterid}"
  app_instance_size = "${var.app_instance_size}"
  gfs_disk_size = "${var.gfs_disk_size}"
  gfs_disk_type = "${var.gfs_disk_type}"
  boot_disk_size = "${var.boot_disk_size}"
  boot_disk_type = "${var.boot_disk_type}"
  docker_disk_size = "${var.docker_disk_size}"
  docker_disk_type = "${var.docker_disk_type}"
  number = "${var.number}"
  subnetwork_name = "${module.network.subnetwork_name}"
  base_image = "${module.create_base_image.image_name}"
}

// Module post install
module "remove_scripts" {
  source = "./modules/post_install"
  zone = "${var.zone}"
  private_ssh_key = "${var.private_ssh_key}"
  master_instance_name = "${module.master_node.master_instance_name}"
  clusterid = "${var.clusterid}"
  infra_instance_name = "${module.infra_node.infra_instance_name}"
  bastion_ip = "${module.network.bastion_public_ip}"
}
