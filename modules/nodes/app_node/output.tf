output "app0_instance_name" {
  value = "${google_compute_instance.app_node[0].name}"
}

output "app1_instance_name" {
  value = "${google_compute_instance.app_node[1].name}"
}

output "app2_instance_name" {
  value = "${google_compute_instance.app_node[2].name}"
}
