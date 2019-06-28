// Create ssh key
resource "null_resource" "create_bastion_private_key" {
  provisioner "local-exec" {
    command = "if [ ! -f '${var.bastion_ssh_key_file}' ]; then ssh-keygen -t rsa -f ${var.bastion_ssh_key_file} -N ''; fi"
  }
}

resource "null_resource" "copy_bastion_private_key" {
  connection {
    type     = "ssh"
    user     = "root"
    host     = "${google_compute_address.bastion-public-ip.address}"
    private_key = "${file(var.private_ssh_key)}"
  }

  provisioner "file" {
    source      = "${var.bastion_ssh_key_file}"
    destination = "/root/.ssh/id_rsa"
  }
  depends_on    = ["null_resource.create_bastion_private_key"]
}
