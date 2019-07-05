resource "google_compute_instance" "infra_node" {
 name         = "${var.clusterid}-infra-0"
 machine_type = "${var.infra_size}"
 tags         = ["${var.clusterid}-infra", "${var.clusterid}-node"]
 metadata = {
  ocp-cluster = "${var.clusterid}"
  osecluster-type = "infra"
  VmDnsSetting = "GlobalOnly"
 }
 boot_disk {
  device_name = "${var.clusterid}-infra-0"
  initialize_params {
   image = "${var.base_image}"
   size  = "${var.boot_disk_size}" 
   type  = "${var.boot_disk_type}"
   }
 }
 attached_disk {
  source = "${var.clusterid}-infra-0-docker"
  device_name = "${var.clusterid}-infra-0-docker"
  mode = "READ_WRITE"
 }
 metadata_startup_script = "export DOCKERDEVICE=$(readlink -f /dev/disk/by-id/google-*docker*); mkfs.xfs $DOCKERDEVICE; mkdir -p /var/lib/docker; echo UUID=$(blkid -s UUID -o value $DOCKERDEVICE) /var/lib/docker xfs defaults,discard 0 2 >> /etc/fstab; mount -a"
// Pesquisar como rodar startup script a partir de um arquivo
 network_interface {
  network = "${var.clusterid}-net"
  subnetwork = "${var.subnetwork-name}"
 access_config {
  nat_ip = "${google_compute_address.apps-public-ip.address}"
   }
 }
 service_account {
    scopes = ["https://www.googleapis.com/auth/cloud.useraccounts.readonly", "https://www.googleapis.com/auth/compute", "https://www.googleapis.com/auth/devstorage.read_write", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol"]
  }
 scheduling {
  on_host_maintenance = "MIGRATE"
 }

// Define dependency resources
depends_on = ["google_compute_disk.infra-docker-disk", "google_compute_address.apps-public-ip"]
}
