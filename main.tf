// Prepare raw disk to create custom ami
resource "null_resource" "create_raw_disk" {
  provisioner "local-exec" {
    command = "wget http://repo.necol.org/iso/rhel-server-7.5-x86_64-kvm.qcow2; sudo apt install qemu-utils -y; qemu-img convert -p -S 4096 -f qcow2 -O raw rhel-server-7.5-x86_64-kvm.qcow2 disk.raw; tar -Szcf rhel-7.5.tar.gz disk.raw"
 }
}

resource "google_storage_bucket" "temp-image-store" {
  name = "${var.clusterid}-rhel-image-temp"
  storage_class = "REGIONAL"
  location = "${var.region}"
  labels = {
    ocp-cluster = "${var.clusterid}"
 }
 depends_on = ["null_resource.create_raw_disk"]
}

resource "google_storage_bucket_object" "rhel-temp-image" {
  name = "rhel-7.5.tar.gz"
  source = "./rhel-7.5.tar.gz"
  bucket = "${google_storage_bucket.temp-image-store.name}"
 depends_on = ["google_storage_bucket.temp-image-store"]
}
