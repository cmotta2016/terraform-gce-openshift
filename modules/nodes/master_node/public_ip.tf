// Create public IP for master node
resource "google_compute_address" "master-public-ip" {
 name = "${var.clusterid}-master"
}
