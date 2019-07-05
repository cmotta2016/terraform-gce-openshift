// Define firewall rules to allow incoming ssh connection to bastion host
resource "google_compute_firewall" "external-to-bastion" {
 name = "${var.clusterid}-external-to-bastion"
 network = "${google_compute_network.osecluster-network.name}"
 allow {
  protocol = "icmp"
 }

 allow {
  protocol = "tcp"
  ports = ["22"]
 }

 priority = "1000"
 direction = "INGRESS"
 source_ranges = ["${var.public_range}"]
 target_tags = ["${var.clusterid}-bastion"]
 depends_on = [google_compute_subnetwork.osecluster-subnetwork]
}

// Define firewall rules to allow incoming connection from any node to bastion
resource "google_compute_firewall" "bastion-to-any" {
 name = "${var.clusterid}-bastion-to-any"
 network = "${google_compute_network.osecluster-network.name}"
 allow {
  protocol = "all"
 }

 priority = "1000"
 direction = "INGRESS"
 source_tags = ["${var.clusterid}-bastion"]
 target_tags = ["${var.clusterid}-node"]
 depends_on = [google_compute_subnetwork.osecluster-subnetwork]
}
