resource "google_compute_instance" "app_node" {
 count = "${var.number}"
 name = "${var.clusterid}-app-${count.index}"
 machine_type = "${var.app_instance_size}"
 tags = ["${var.clusterid}-node"]
 metadata = {
  ocp-cluster = "${var.clusterid}"
  osecluster-type = "app"
  VmDnsSetting = "GlobalOnly"
}
 boot_disk {
  device_name = "${var.clusterid}-app-${count.index}"
  initialize_params {
   image = "${var.base_image}"
   size  = "${var.boot_disk_size}" 
   type  = "${var.boot_disk_type}"
   }
 }
 attached_disk {
  source = "${google_compute_disk.app_docker_disk[count.index].name}"
  device_name = "${google_compute_disk.app_docker_disk[count.index].name}"
  mode = "READ_WRITE"
 }
 attached_disk {
  source = "${google_compute_disk.app_gfs_disk_1[count.index].name}"
  device_name = "${google_compute_disk.app_gfs_disk_1[count.index].name}"
  mode = "READ_WRITE"
 }
 attached_disk {
  source = "${google_compute_disk.app_gfs_disk_2[count.index].name}"
  device_name = "${google_compute_disk.app_gfs_disk_2[count.index].name}"
  mode = "READ_WRITE"
 }
 attached_disk {
  source = "${google_compute_disk.app_gfs_disk_3[count.index].name}"
  device_name = "${google_compute_disk.app_gfs_disk_3[count.index].name}"
  mode = "READ_WRITE"
 }
 metadata_startup_script = "export DOCKERDEVICE=$(readlink -f /dev/disk/by-id/google-*docker*); mkfs.xfs $DOCKERDEVICE; mkdir -p /var/lib/docker; echo UUID=$(blkid -s UUID -o value $DOCKERDEVICE) /var/lib/docker xfs defaults,discard 0 2 >> /etc/fstab; mount -a"
 network_interface {
  network = "${var.clusterid}-net"
  subnetwork = "${var.subnetwork_name}"
 access_config {
   }
 }
 service_account {
    scopes = ["https://www.googleapis.com/auth/cloud.useraccounts.readonly", "https://www.googleapis.com/auth/compute", "https://www.googleapis.com/auth/devstorage.read_write", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol"]
  }
 scheduling {
  on_host_maintenance = "MIGRATE"
 }

// Define dependency resources
depends_on = ["google_compute_disk.app_docker_disk", "google_compute_disk.app_gfs_disk_3"]
}
