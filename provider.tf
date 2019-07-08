// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("tf-ose-sa.json")}"
 project     = "${var.project}"
 region      = "${var.region}"
 zone        = "${var.zone}"
}
