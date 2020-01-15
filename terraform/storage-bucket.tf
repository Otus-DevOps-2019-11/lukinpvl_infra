provider "google" {
  version = "~> 2.15"
  project = var.project
  region  = var.region
}

module "storage-bucket" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.3.0"

  # Имя поменяйте на другое
  name = "storage-bucket-stage"
}
module "storage-bucket" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.3.0"

  # Имя поменяйте на другое
  name = "storage-bucket-prod"
}

output storage-bucke-stage__url {
  value = module.storage-bucket-stage.url
}

output storage-bucket-prod_url {
  value = module.storage-bucket-prod.url
}
