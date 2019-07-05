// Create public IP for master node
resource "google_compute_address" "master_public_ip" {
 name = "${var.clusterid}-master"
}
