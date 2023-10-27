data vsphere_datacenter "this" {
  name = var.datacenter_name
}

data vsphere_compute_cluster "this" {
  name          = var.cluster_name
  datacenter_id = data.vsphere_datacenter.this.id
}

data vsphere_datastore "this" {
  name          = var.datastore_name
  datacenter_id = data.vsphere_datacenter.this.id
}

data vsphere_network "this" {
  name          = var.vm_network_name
  datacenter_id = data.vsphere_datacenter.this.id
}



# Data source for vCenter Content Library
data "vsphere_content_library" "my_content_library" {
  name = "misc"
}

# Data source for vCenter Content Library Item
data "vsphere_content_library_item" "my_ovf_item" {
  name       = "ubuntu-22.04-server-cloudimg-amd64"
  type       = "ovf"
  library_id = data.vsphere_content_library.my_content_library.id
}
