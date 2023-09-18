module "ubuntu_node" {
  source = "../ubuntu_node"
  hostname="tap-iterate"
  num_cpus=4
  memory=16384
  disk_size=60
  execution_cmd=lookup(tanzu-mission-control_cluster.attach_cluster_without_apply.status,"execution_cmd","unkown")
}



provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

provider "tanzu-mission-control" {
  endpoint            = var.endpoint            # optionally use TMC_ENDPOINT env var
  vmw_cloud_api_token = var.vmw_cloud_api_token # optionally use VMW_CLOUD_API_TOKEN env var

}

resource "tanzu-mission-control_cluster" "attach_cluster_without_apply" {
  management_cluster_name = "attached"         # Default: attached
  provisioner_name        = "attached"         # Default: attached
  name                    = "tap-iterate" # Required

  meta {
    description = "create attach cluster from terraform"
    labels      = { "key" : "value" }
  }

  spec {
    cluster_group = "homelab" # Default: default
  }

#  ready_wait_timeout = "0s" # Shouldn't wait for the default time of 3m in this case

  # The deployment link and the command needed to be run to attach this cluster would be provided in the output.status.execution_cmd
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
