// Define firewall rules to allow incoming ssh connection to bastion host
resource "google_compute_firewall" "ssh-temp" {
 name = "${var.clusterid}-ssh-temp"
// network = "${google_compute_network.osecluster-network.name}"
 network = "${var.network-name}"

 allow {
  protocol = "tcp"
  ports = ["22"]
 }

 priority = "1000"
 direction = "INGRESS"
 source_ranges = ["${var.public_ranges}"]
 target_tags = ["${var.clusterid}-temp"]
// depends_on = [google_compute_subnetwork.osecluster-subnetwork]
}
