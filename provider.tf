// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("<your_service_account_created_json_file>")}"
 project     = "${var.project}"
 region      = "${var.region}"
 zone        = "${var.zone}"
}
