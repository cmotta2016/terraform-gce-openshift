output "network_name" {
 value = "${google_compute_network.osecluster-network.name}"
}

output "subnetwork_name" {
 value = "${google_compute_subnetwork.osecluster-subnetwork.name}"
}

output "bastion_public_ip" {
  value = "${google_compute_address.bastion_public_ip.address}"
}

output "master_public_ip" {
  value = "${google_compute_address.master_public_ip.address}"
}

output "infra_public_ip" {
  value = "${google_compute_address.apps_public_ip.address}"
}
