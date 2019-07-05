// Create additional disk to be used by docker
resource "google_compute_disk" "infra_docker_disk" {
 name = "${var.clusterid}-infra-0-docker"
 type = "${var.docker_disk_type}"
 size = "${var.docker_disk_size}"
}
