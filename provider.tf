// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("terraform-project-244918-b89085889be4.json")}"
 project     = "${var.project}"
 region      = "${var.region}"
 zone        = "${var.zone}"
}
