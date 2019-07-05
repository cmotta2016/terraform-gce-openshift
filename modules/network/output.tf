output "network-name" {
 value = "${google_compute_network.osecluster-network.name}"
}

output "subnetwork-name" {
 value = "${google_compute_subnetwork.osecluster-subnetwork.name}"
}
