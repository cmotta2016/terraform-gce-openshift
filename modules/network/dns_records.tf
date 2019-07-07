resource "google_dns_record_set" "console" {
//  name = "console.${var.clusterid}.${google_dns_managed_zone.prod.dns_name}"
  name = "console.${var.clusterid}.${var.domain}"
  type = "A"
  ttl  = 300
  
//  managed_zone = "${google_dns_managed_zone.prod.name}"
  managed_zone = "${var.managed-zone-name}"
  rrdatas = ["${google_compute_address.master_public_ip.address}"]
}

resource "google_dns_record_set" "apps" {
//  name = "apps.${var.clusterid}.${google_dns_managed_zone.prod.dns_name}"
  name = "*.apps.${var.clusterid}.${var.domain}"
  type = "A"
  ttl  = 300
  
//  managed_zone = "${google_dns_managed_zone.prod.name}"
  managed_zone = "${var.managed-zone-name}"
  rrdatas = ["${google_compute_address.infra_public_ip.address}"]
}

resource "google_dns_record_set" "bastion" {
//  name = "bastion.${var.clusterid}.${google_dns_managed_zone.prod.dns_name}"
  name = "bastion.${var.clusterid}.${var.domain}"
  type = "A"
  ttl  = 300
  
//  managed_zone = "${google_dns_managed_zone.prod.name}"
  managed_zone = "${var.managed-zone-name}"
  rrdatas = ["${google_compute_address.bastion_public_ip.address}"]
}
