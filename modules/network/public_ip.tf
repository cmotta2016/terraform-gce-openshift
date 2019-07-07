// Create public IP for bastion node
resource "google_compute_address" "bastion_public_ip" {
 name = "${var.clusterid}-bastion"
 region = "${var.region}"
}

// Create public IP for infra node
resource "google_compute_address" "apps_public_ip" {
 name = "${var.clusterid}-apps"
 region = "${var.region}"
}

// Create public IP for master node
resource "google_compute_address" "master_public_ip" {
 name = "${var.clusterid}-master"
 region = "${var.region}"
}
