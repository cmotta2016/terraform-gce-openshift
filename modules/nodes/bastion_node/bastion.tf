resource "google_compute_instance" "bastion_node" {
 name         = "${var.clusterid}-bastion"
 machine_type = "${var.bastion_size}"
 tags         = ["${var.clusterid}-bastion"]
 metadata = {
  ocp-cluster = "${var.clusterid}"
  osecluster-type = "bastion"
  VmDnsSetting = "GlobalOnly"
  ssh-keys = "jeniffer_jc29:${file(var.bastion_ssh_key_file)}"
 }
 boot_disk {
  device_name = "${var.clusterid}-bastion"
  initialize_params {
   image = "${var.base_image_family}/${var.base_image_name}"
   size  = "${var.bastion_disk_size}" 
   type  = "${var.bastion_disk_type}"
   }
 }
// Pesquisar como rodar startup script a partir de um arquivo
// metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq apache2"
 network_interface {
  network = "${var.clusterid}-net"
  subnetwork = "${var.subnetwork-name}" 
 access_config {
  nat_ip = "${google_compute_address.bastion-public-ip.address}"
   }
 }
 service_account {
    scopes = ["https://www.googleapis.com/auth/cloud.useraccounts.readonly", "https://www.googleapis.com/auth/compute", "https://www.googleapis.com/auth/devstorage.read_write", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol"]
  }
 scheduling {
  on_host_maintenance = "MIGRATE"
 }
 depends_on = ["google_compute_address.bastion-public-ip"]
}
