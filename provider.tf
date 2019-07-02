// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("terraform-openshift-ef2ee8cedf72.json")}"
 project     = "${var.project}"
 region      = "${var.region}"
 zone        = "${var.zone}"
}
