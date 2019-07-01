output "bastion_public_ip" {
  value = "${google_compute_address.bastion-public-ip.address}"
}
