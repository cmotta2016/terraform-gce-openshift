// Create base image
resource "google_compute_image" "create_rhel_image" {
  name = "${var.clusterid}-base-image"
  family = "${var.image-family}" 
//  source_disk = "${google_compute_instance.temp_instance.boot_disk[0].device_name}"
  source_disk = "${var.clusterid}-temp"
//  depends_on = ["null_resource.copy_files", "google_compute_instance.temp_instance"]
//  depends_on = ["null_resource.copy_files"]
}
