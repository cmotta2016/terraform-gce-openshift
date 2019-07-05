resource "null_resource" "copy_files" {
  connection {
    type     = "ssh"
    user     = "cloud-user"
    host     = "${google_compute_address.temp_public_ip.address}"
    private_key = "${file(var.private_ssh_key)}"
  }
  provisioner "file" {
    source      = "${path.cwd}/modules/image/google-cloud.repo"
    destination = "/tmp/google-cloud.repo"
  }
  provisioner "file" {
    source      = "${path.cwd}/modules/image/ifcfg-eth0"
    destination = "/tmp/ifcfg-eth0"
  }
  provisioner "file" {
    source      = "${path.cwd}/modules/image/scripts"
    destination = "/tmp"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo cp -r /tmp/google-cloud.repo /etc/yum.repos.d/ ",
      "sudo cp -r /tmp/ifcfg-eth0 /etc/sysconfig/network-scripts/",
      "sudo chmod +x /tmp/scripts/*",
      "sudo /tmp/scripts/rhn_register.sh ${var.rhn_username} ${var.rhn_password} ${var.pool_id}",
      "sudo /tmp/scripts/script.sh",
      "sudo rm -rf /tmp/*",
      "sudo shutdown -P +1",
      "sudo echo 0",
    ]
  }
   provisioner "local-exec" {
     command = "sleep 80"
  }
  depends_on    = ["google_compute_instance.temp_instance"]
}
