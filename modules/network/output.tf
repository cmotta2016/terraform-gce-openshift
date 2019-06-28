output "network_name" {
 value = "${google_compute_network.osecluster-network.name}"
}

output "subnetwork-name" {
 value = "${google_compute_subnetwork.osecluster-subnetwork.name}"
}
