resource "null_resource" "removing_startup_scripts" {
  connection {
    type     = "ssh"
    user     = "jeniffer_jc29"
//    host     = "${google_compute_address.bastion-public-ip.address}"
    host = "${var.bastion_ip}"
    private_key = "${file(var.private_ssh_key)}"
  }
  provisioner "remote-exec" {
    inline = [
      "gcloud compute instances remove-metadata --keys startup-script ${var.master-name} --zone=${var.zone}",
      "gcloud compute instances remove-metadata --keys startup-script ${var.infra-name} --zone=${var.zone}",
      "for i in 0 1 2; do gcloud compute instances remove-metadata --keys startup-script ${var.clusterid}-app-$i --zone=${var.zone}; done",
    ]
  }
}

variable "master-name" {
}

variable "clusterid" {
}

variable "zone" {
}

variable "infra-name" {
}

variable "private_ssh_key" {
 default = "~/.ssh/tf-ssh-key"
}

variable "bastion_ip" {
}
