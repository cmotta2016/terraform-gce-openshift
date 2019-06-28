// Create public IP for infra node
resource "google_compute_address" "apps-public-ip" {
 name = "${var.clusterid}-apps"
}
