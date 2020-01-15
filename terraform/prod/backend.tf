terraform {
  required_version = "~> 0.12.8"
  backend "gcs" {
    bucket = "storage-bucket-prod"
    prefix = "terraform/state"
  }
}
