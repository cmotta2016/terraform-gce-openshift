output "master_instance_name" {
  value = "${google_compute_instance.master_node.name}"
}
