// Define firewall rules from node to node
resource "google_compute_firewall" "node-to-node" {
 name = "${var.clusterid}-node-to-node"
 network = "${google_compute_network.osecluster-network.name}"
 allow {
  protocol = "udp"
  ports = ["4789"]
 }
  allow {
  protocol = "tcp"
  ports = ["9100", "8444"]
 }
 priority = "1000"
 direction = "INGRESS"
 source_tags = ["${var.clusterid}-node"]
 target_tags = ["${var.clusterid}-node"]
 depends_on = [google_compute_subnetwork.osecluster-subnetwork]
}

// Define firewall rules from infra to node
resource "google_compute_firewall" "infra-to-node" {
 name = "${var.clusterid}-infra-to-node"
 network = "${google_compute_network.osecluster-network.name}"
 allow {
  protocol = "tcp"
  ports = ["10250"]
 }
 priority = "1000"
 direction = "INGRESS"
 source_tags = ["${var.clusterid}-infra"]
 target_tags = ["${var.clusterid}-node"]
 depends_on = [google_compute_subnetwork.osecluster-subnetwork]
}

// Define GlusterFS firewall rules between nodes
resource "google_compute_firewall" "gfs-to-gfs" {
 name = "${var.clusterid}-gfs-to-gfs"
 network = "${google_compute_network.osecluster-network.name}"
 allow {
  protocol = "tcp"
  ports = ["2222"]
 }
 priority = "1000"
 direction = "INGRESS"
 source_tags = ["${var.clusterid}-gfs"]
 target_tags = ["${var.clusterid}-gfs"]
 depends_on = [google_compute_subnetwork.osecluster-subnetwork]
}

// Define GlusterFS firewall rules from node to gfs
resource "google_compute_firewall" "node-to-gfs" {
 name = "${var.clusterid}-node-to-gfs"
 network = "${google_compute_network.osecluster-network.name}"
 allow {
  protocol = "tcp"
  ports = ["111", "3260", "24007-24010", "49152-49664"]
 }
 allow {
  protocol = "udp"
  ports = ["111"]
 }
 priority = "1000"
 direction = "INGRESS"
 source_tags = ["${var.clusterid}-node"]
 target_tags = ["${var.clusterid}-gfs"]
 depends_on = [google_compute_subnetwork.osecluster-subnetwork]
}
