// Define firewall rules to allow connection between nodes to master node
resource "google_compute_firewall" "node-to-master" {
 name = "${var.clusterid}-node-to-master"
 network = "${google_compute_network.osecluster-network.name}"
 allow {
  protocol = "tcp"
  ports = ["8053"]
 }
 allow {
  protocol = "udp"
  ports = ["8053"]
 }
 priority = "1000"
 direction = "INGRESS"
 source_tags = ["${var.clusterid}-node"]
 target_tags = ["${var.clusterid}-master"]
 depends_on = [google_compute_subnetwork.osecluster-subnetwork]
}

// Define firewall rules to allow connection between master to node
resource "google_compute_firewall" "master-to-node" {
 name = "${var.clusterid}-master-to-node"
 network = "${google_compute_network.osecluster-network.name}"
 allow {
  protocol = "tcp"
  ports = ["10250"]
 }
 priority = "1000"
 direction = "INGRESS"
 source_tags = ["${var.clusterid}-master"]
 target_tags = ["${var.clusterid}-node"]
 depends_on = [google_compute_subnetwork.osecluster-subnetwork]
}

// Define firewall rules to allow connection between master to master
resource "google_compute_firewall" "master-to-master" {
 name = "${var.clusterid}-master-to-master"
 network = "${google_compute_network.osecluster-network.name}"
 allow {
  protocol = "tcp"
  ports = ["2379", "2380"]
 }
 priority = "1000"
 direction = "INGRESS"
 source_tags = ["${var.clusterid}-master"]
 target_tags = ["${var.clusterid}-master"]
 depends_on = [google_compute_subnetwork.osecluster-subnetwork]
}

// Define firewall rules to allow connection from any to master
resource "google_compute_firewall" "any-to-master" {
 name = "${var.clusterid}-any-to-master"
 network = "${google_compute_network.osecluster-network.name}"
 allow {
  protocol = "tcp"
  ports = ["443", "80"]
 }
 priority = "1000"
 direction = "INGRESS"
 source_ranges = ["${var.private_ranges}", "${var.public_ranges}"]
 target_tags = ["${var.clusterid}-master"]
 depends_on = [google_compute_subnetwork.osecluster-subnetwork]
}
