output "image-family" {
  value = "${google_compute_image.create_temp_rhel_image.family}"
}

output "image-name" {
  value = "${google_compute_image.create_temp_rhel_image.name}"
}

//output "temp_public_ip" {
 // value = "${google_compute_instance.temp_instance.address}"
//}
