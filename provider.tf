// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("<your_service_account.json>")}"
 project     = "${var.project}"
 region      = "${var.region}"
 zone        = "${var.zone}"
}
