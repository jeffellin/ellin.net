module "ubuntu_node" {
  source = "../ubuntu_worker"
  hostname="tap-view-2"
  num_cpus=8
  disk_size=64
  memory=16384
  datastore_name="ESX4--SSD-1"
  execution_cmd="ls"
}



provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}


# terraform {
#  backend "s3" {
#    bucket = "terraform"
#    key = "terraform.tfstate"
#
#    endpoint = "https://192.168.1.94:9000"
#
#    access_key="cS5fJPr4WH5NRkc4bYYz"
#    secret_key="5hRGkGfK023mYJgMyOYeCik4jScNHsvYArLzE5rK"

 #   region = "main"
 #   skip_credentials_validation = true
 #   skip_metadata_api_check = true
 #   skip_region_validation = true
 #   force_path_style = true
 # }
#}

variable "vsphere_server" {
  type = string
}

variable "vsphere_user" {
  type = string
}

variable "vsphere_password" {
  type = string
}
