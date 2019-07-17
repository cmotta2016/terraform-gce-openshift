resource "null_resource" "preparing_bastion" {
  connection {
    type     = "ssh"
    user     = "${var.google_user}"
    host = "${var.bastion_public_ip}"
//   host     = "${google_compute_address.bastion_public_ip.address}"
    private_key = "${file(var.private_ssh_key)}"
  }
  provisioner "file" {
    source      = "${path.cwd}/modules/nodes/bastion_node/conf/ansible.cfg"
    destination = "/tmp/ansible.cfg"
  }
  provisioner "file" {
    source      = "${path.cwd}/modules/nodes/bastion_node/scripts/rhn_register.sh"
    destination = "/tmp/rhn_register.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/rhn_register*",
      "sudo /tmp/rhn_register.sh ${var.rhn_username} ${var.rhn_password} ${var.pool_id}",
      "sudo cp -r /tmp/ansible.cfg /etc/ansible/ ",
      "sudo rm -rf /tmp/*",
      "sudo shutdown -r +1",
      "sudo echo 0",
    ]
  }
  depends_on    = ["google_compute_instance.bastion_node"]
}
