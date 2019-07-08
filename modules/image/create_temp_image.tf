// Prepare raw disk to create custom ami
resource "null_resource" "create_raw_disk" {
  provisioner "local-exec" {
    command = "if [ ! -f rhel-server-7.5-x86_64-kvm.qcow2 ]; then wget http://repo.necol.org/iso/rhel-server-7.5-x86_64-kvm.qcow2; fi; apt install qemu-utils -y; if [ ! -f disk.raw ]; then qemu-img convert -p -S 4096 -f qcow2 -O raw rhel-server-7.5-x86_64-kvm.qcow2 disk.raw; fi; if [ ! -f rhel-7.5.tar.gz ]; then tar -Szcf rhel-7.5.tar.gz disk.raw; fi"
 }
}

// Create temporary bucket
resource "google_storage_bucket" "temp_bucket" {
//  name = "${var.clusterid}-temp-bucket-name"
  name = "${var.bucket_name}"
  storage_class = "REGIONAL"
  location = "${var.region}"
  labels = {
    ocp-cluster = "${var.clusterid}"
 }
}

// Upload tar file to temporary bucket
resource "google_storage_bucket_object" "rhel_temp_image" {
  name = "rhel-7.5.tar.gz"
  source = "./rhel-7.5.tar.gz"
  bucket = "${google_storage_bucket.temp_bucket.name}"
  depends_on = ["google_storage_bucket.temp_bucket", "null_resource.create_raw_disk"]
}

// Remove files from localhost
resource "null_resource" "delete_files" {
  provisioner "local-exec" {
    command = "rm -rf rhel-* disk.raw"
  }
  depends_on = ["google_storage_bucket_object.rhel_temp_image"]
}

// Create temp image from tar file
resource "google_compute_image" "create_temp_rhel_image" {
  name = "${var.clusterid}-rhel-temp-image"
  family = "${var.image_family}" 
  raw_disk {
    source = "https://storage.googleapis.com/${google_storage_bucket_object.rhel_temp_image.bucket}/${google_storage_bucket_object.rhel_temp_image.name}"
  }
 depends_on = ["google_storage_bucket_object.rhel_temp_image"]
}

// Create public IP for temporary instance
resource "google_compute_address" "temp_public_ip" {
 name = "${var.clusterid}-temp"
 region = "${var.region}"
}

// Define firewall rules to allow incoming ssh connection to temp instance
resource "google_compute_firewall" "ssh_temp" {
 name = "${var.clusterid}-ssh-temp"
 network = "default"

 allow {
  protocol = "tcp"
  ports = ["22"]
 }

 priority = "1000"
 direction = "INGRESS"
 source_ranges = ["${var.public_range}"]
 target_tags = ["${var.clusterid}-temp"]
}

// Create temporary instance
resource "google_compute_instance" "temp_instance" {
 name         = "${var.clusterid}-temp"
 machine_type = "${var.temp_size}"
 tags         = ["${var.clusterid}-temp"]
 zone = "${var.zone}"
 boot_disk {
  device_name = "${var.clusterid}-temp"
  initialize_params {
   image = "${google_compute_image.create_temp_rhel_image.name}"
   size  = "${var.temp_disk_size}" 
   type  = "${var.temp_disk_type}"
   }
 }
 network_interface {
  network = "default"
  access_config {
    nat_ip = "${google_compute_address.temp_public_ip.address}"
   }
 }
 service_account {
    scopes = ["https://www.googleapis.com/auth/cloud.useraccounts.readonly", "https://www.googleapis.com/auth/compute", "https://www.googleapis.com/auth/devstorage.read_write", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol"]
  }
 scheduling {
  on_host_maintenance = "MIGRATE"
 }
 depends_on = ["google_compute_image.create_temp_rhel_image", "google_compute_address.temp_public_ip"]
}
