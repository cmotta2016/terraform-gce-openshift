// Create additional disk to be used by docker
resource "google_compute_disk" "app_docker_disk" {
 count = "${var.number}"
 name = "${var.clusterid}-app-${count.index}-docker"
 type = "${var.docker_disk_type}"
 size = "${var.docker_disk_size}"
}
