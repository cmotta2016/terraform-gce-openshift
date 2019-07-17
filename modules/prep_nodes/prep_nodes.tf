resource "null_resource" "preparing_nodes" {
  connection {
    type     = "ssh"
    user     = "${var.google_user}"
    host = "${var.bastion_public_ip}"
    private_key = "${file(var.private_ssh_key)}"
  }
  provisioner "file" {
    source      = "${path.cwd}/modules/prep_nodes/scripts/create_host_file.sh"
    destination = "/tmp/create_host_file.sh"
  }
  provisioner "file" {
    source      = "${path.cwd}/modules/prep_nodes/scripts/rhn_register.sh"
    destination = "/tmp/rhn_register.sh"
  }
  provisioner "file" {
    source      = "${var.private_ssh_key}"
    destination = "~/.ssh/id_rsa"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/rhn_register*",
      "sudo chmod +x /tmp/create_host_file.sh",
      "sudo chmod 400 ~/.ssh/id_rsa",
      "sudo /tmp/create_host_file.sh ${var.master_instance_name} ${var.infra_instance_name} ${var.app0_instance_name} ${var.app1_instance_name} ${var.app2_instance_name}",
    ]
  }
}

resource "null_resource" "register_nodes" {
  provisioner "local-exec" {
    command = "ssh -i ${var.private_ssh_key} -o StrictHostKeyChecking=no ${var.google_user}@${var.bastion_public_ip} '/tmp/rhn_register.sh ${var.rhn_username} ${var.rhn_password} ${var.pool_id}; sudo rm -rf /tmp/*; echo 0'"
  }
  provisioner "local-exec" {
     command = "sleep 100"
  }
  depends_on = ["null_resource.preparing_nodes"]
}
