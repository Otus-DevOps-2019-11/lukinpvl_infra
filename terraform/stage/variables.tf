variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west1"
}
variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable disk_image {
  description = "Disk image"
}
variable private_key_path {
  description = "Path to the private key user for ssh access"
}
variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}
variable target_tags {
  description = "Target tags"
}
variable instance_count {
  description = "Instanse count"
  default     = 1
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
