resource "google_compute_subnetwork" "osecluster-subnetwork" {
  name = "${var.clusterid}-subnet"
  network = "${google_compute_network.osecluster-network.name}"
  ip_cidr_range = "${var.private_range}"
}
