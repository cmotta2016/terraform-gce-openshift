output "infra_instance_name" {
  value = "${google_compute_instance.infra_node.name}"
}
