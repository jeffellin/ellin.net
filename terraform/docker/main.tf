module "ubuntu_node" {
  source = "../ubuntu_node"
  hostname="docker"
  disk_size=64
  datastore_name="ESX2-2TB-SSD"
}



provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}


variable "vsphere_server" {
  type = string
}

variable "vsphere_user" {
  type = string
}

variable "vsphere_password" {
  type = string
}
