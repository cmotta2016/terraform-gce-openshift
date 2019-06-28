// Create public IP for bastion node
resource "google_compute_address" "bastion-public-ip" {
 name = "${var.clusterid}-bastion"
 region = "${var.region}"
}
