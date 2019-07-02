resource "google_compute_instance" "temp_instance" {
 name         = "${var.clusterid}-temp"
 machine_type = "${var.temp_size}"
 tags         = ["${var.clusterid}-temp"]
 zone = "${var.zone}"
// metadata = {
//  ocp-cluster = "${var.clusterid}"
//  osecluster-type = "bastion"
//  VmDnsSetting = "GlobalOnly"
//  ssh-keys = "jeniffer_jc29:${file(var.bastion_ssh_key_file)}"
// }
 boot_disk {
  device_name = "${var.clusterid}-temp"
  initialize_params {
//   image = "${var.base_image_name}"
   image = "${google_compute_image.create_temp_rhel_image.name}"
   size  = "${var.temp_disk_size}" 
   type  = "${var.temp_disk_type}"
   }
 }
// Pesquisar como rodar startup script a partir de um arquivo
// metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq apache2"
 network_interface {
  network = "default"
//  subnetwork = "${var.subnetwork-name}" 
 access_config {
//  nat_ip = "${google_compute_address.bastion-public-ip.address}"
   }
 }
 service_account {
    scopes = ["https://www.googleapis.com/auth/cloud.useraccounts.readonly", "https://www.googleapis.com/auth/compute", "https://www.googleapis.com/auth/devstorage.read_write", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol"]
  }
 scheduling {
  on_host_maintenance = "MIGRATE"
 }
// depends_on = ["google_compute_address.bastion-public-ip"]
 depends_on = ["google_compute_image.create_temp_rhel_image"]
}
