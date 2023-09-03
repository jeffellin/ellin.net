variable datacenter_name {
  type        = string
  default = "Datacenter"
  description = "The name of the vSphere Datacenter into which resources will be created."
}
variable cluster_name {
  type        = string
  default = "lab"
  description = "The vSphere Cluster into which resources will be created."
}
variable datastore_name {
  type        = string
  default = "synology"
  description = "The vSphere Datastore into which resources will be created."
}
variable vm_network_name {
  type = string
  default = "VM Network"
  description = "The name of the Vsphere Port Group"
}
variable hostname {
  type        = string
  default     = "ubuntu"
  description = "The virtual machine name in vCenter."
}

variable num_cpus {
  type = number
  default = 2
  description = "the number of cpus for the VM"
}

variable memory {
  type = number
  default = 4096
  description = "the memory in MB for the VM"
}

variable execution_cmd {
  type = string
  description = "the memory in MB for the VM"
}