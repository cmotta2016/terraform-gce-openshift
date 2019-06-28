// Create additional disk to be used by docker
resource "google_compute_disk" "master-docker-disk" {
 name = "${var.clusterid}-master-0-docker"
 type = "${var.docker_disk_type}"
 size = "${var.docker_disk_size}"
// zone = "${var.zone}"
}
