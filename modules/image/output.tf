output "image_family" {
  value = "${google_compute_image.create_temp_rhel_image.family}"
}

output "image_name" {
  value = "${google_compute_image.create_temp_rhel_image.name}"
}

output "temp_public_ip" {
  value = "${google_compute_address.temp_public_ip.address}"
}

output "disk_name" {
  value = "${google_compute_instance.temp_instance.boot_disk[0].device_name}"
}
