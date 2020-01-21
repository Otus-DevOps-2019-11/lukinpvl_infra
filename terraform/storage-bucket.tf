provider "google" {
  version = "~> 2.15"
  project = var.project
  region  = var.region
}

module "storage-bucket-stage" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.3.0"
  location = var.region
  force_destroy = true
  name = "storage-bucket-stage-1"
}
module "storage-bucket-prod"{
  source  = "SweetOps/storage-bucket/google"
  version = "0.3.0"
  location = var.region
  force_destroy = true
  name = "storage-bucket-prod-1"
}

output storage-bucke-stage__url {
  value = module.storage-bucket-stage.url
}

output storage-bucket-prod_url {
  value = module.storage-bucket-prod.url
}
