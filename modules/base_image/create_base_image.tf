// Create base image
resource "google_compute_image" "create_rhel_image" {
  name = "${var.clusterid}-base-image"
  family = "${var.image_family}" 
  source_disk = "${var.clusterid}-temp"
}
