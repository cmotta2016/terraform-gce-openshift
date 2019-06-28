resource "google_compute_network" "osecluster-network" {
  name = "${var.clusterid}-net"
  auto_create_subnetworks = "false"
}
