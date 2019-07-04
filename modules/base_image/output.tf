output "image_name" {
  value = "${google_compute_image.create_rhel_image.name}"
}

output "image_family" {
  value = "${google_compute_image.create_rhel_image.family}"
}
