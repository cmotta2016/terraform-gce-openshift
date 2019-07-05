// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("your-service-account-file.json")}"
 project     = "${var.project}"
 region      = "${var.region}"
 zone        = "${var.zone}"
}
