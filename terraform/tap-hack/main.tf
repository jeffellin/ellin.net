module "ubuntu_node" {
  source = "../ubuntu_node"
  hostname="tap-hack"
  num_cpus=12
  disk_size=64
  memory=32768
  datastore_name="ESX2-2TB-SSD"
  execution_cmd="ls"
}



provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}



terraform {
  required_providers {
    tanzu-mission-control = {
      source = "vmware/tanzu-mission-control"
      version = "1.2.2"
    }
  }
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
