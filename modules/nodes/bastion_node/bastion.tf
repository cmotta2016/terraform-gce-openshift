resource "google_compute_instance" "bastion_node" {
 name         = "${var.clusterid}-bastion"
 machine_type = "${var.bastion_instance_size}"
 tags         = ["${var.clusterid}-bastion"]
 metadata = {
  ocp-cluster = "${var.clusterid}"
  osecluster-type = "bastion"
  VmDnsSetting = "GlobalOnly"
  ssh-keys = "${var.google_user}:${file(var.public_ssh_key)}"
 }
 boot_disk {
  device_name = "${var.clusterid}-bastion"
  initialize_params {
   image = "${var.base_image}"
   size  = "${var.bastion_disk_size}" 
   type  = "${var.bastion_disk_type}"
   }
 }
// Pesquisar como rodar startup script a partir de um arquivo
 network_interface {
//  network = "${var.clusterid}-net"
  network = "${var.network_name}"
  subnetwork = "${var.subnetwork_name}" 
 access_config {
  nat_ip = "${var.bastion_public_ip}"
   }
 }
 service_account {
    scopes = ["https://www.googleapis.com/auth/cloud.useraccounts.readonly", "https://www.googleapis.com/auth/compute", "https://www.googleapis.com/auth/devstorage.read_write", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol"]
  }
 scheduling {
  on_host_maintenance = "MIGRATE"
 }
// depends_on = ["google_compute_address.bastion_public_ip"]
}
