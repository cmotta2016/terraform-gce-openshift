output "image-family" {
  value = "${google_compute_image.create_temp_rhel_image.family}"
}

output "image-name" {
  value = "${google_compute_image.create_temp_rhel_image.name}"
}

output "temp_public_ip" {
//  value = "${google_compute_instance.temp_instance.address}"
  value = "${google_compute_address.temp-public-ip.address}"
}

output "disk_name" {
  value = "${google_compute_instance.temp_instance.boot_disk[0].device_name}"
}
//output "base_image" {
//  value = "${google_compute_image.create_base_image.name}"
//}
