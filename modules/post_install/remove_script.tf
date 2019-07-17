resource "null_resource" "removing_startup_scripts" {
  connection {
    type = "ssh"
    user = "${var.google_user}"
    host = "${var.bastion_ip}"
    private_key = "${file(var.private_ssh_key)}"
  }
  provisioner "remote-exec" {
    inline = [
      "gcloud compute instances remove-metadata --keys startup-script ${var.master_instance_name} --zone=${var.zone}",
      "gcloud compute instances remove-metadata --keys startup-script ${var.infra_instance_name} --zone=${var.zone}",
      "for i in 0 1 2; do gcloud compute instances remove-metadata --keys startup-script ${var.clusterid}-app-$i --zone=${var.zone}; done",
    ]
  }
}
