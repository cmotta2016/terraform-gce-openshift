// Create additional disks to be used by gfs
resource "google_compute_disk" "app_gfs_disk_1" {
 count = "${var.number}"
 name = "${var.clusterid}-app-${count.index}-gfs-1"
 type = "${var.gfs_disk_type}"
 size = "${var.gfs_disk_size}"
}

resource "google_compute_disk" "app_gfs_disk_2" {
 count ="${var.number}"
 name = "${var.clusterid}-app-${count.index}-gfs-2"
 type = "${var.gfs_disk_type}"
 size = "${var.gfs_disk_size}"
}

resource "google_compute_disk" "app_gfs_disk_3" {
 count ="${var.number}"
 name = "${var.clusterid}-app-${count.index}-gfs-3"
 type = "${var.gfs_disk_type}"
 size = "${var.gfs_disk_size}"
}
