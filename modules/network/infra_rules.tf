// Define firewall rules infra node to infra node
resource "google_compute_firewall" "infra-to-infra" {
 name = "${var.clusterid}-infra-to-infra"
 network = "${google_compute_network.osecluster-network.name}"
 allow {
  protocol = "tcp"
  ports = ["9200", "9300"]
 }
 priority = "1000"
 direction = "INGRESS"
 source_tags = ["${var.clusterid}-infra"]
 target_tags = ["${var.clusterid}-infra"]
 depends_on = [google_compute_subnetwork.osecluster-subnetwork]
}

// Define firewall rules to allow incoming traffic from any to routers
resource "google_compute_firewall" "any-to-routers" {
 name = "${var.clusterid}-any-to-routers"
 network = "${google_compute_network.osecluster-network.name}"
 allow {
  protocol = "tcp"
  ports = ["80", "443"]
 }
 priority = "1000"
 direction = "INGRESS"
 source_ranges = ["${var.public_range}"]
 target_tags = ["${var.clusterid}-infra"]
 depends_on = [google_compute_subnetwork.osecluster-subnetwork]
}
