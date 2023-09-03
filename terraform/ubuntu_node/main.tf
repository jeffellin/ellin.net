resource "tls_private_key" "tls_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource vsphere_virtual_machine "this" {
  name             = var.hostname
  resource_pool_id = data.vsphere_compute_cluster.this.resource_pool_id
  datastore_id     = data.vsphere_datastore.this.id
  ept_rvi_mode   = "automatic"
  hv_mode  = "hvAuto"
  num_cpus = var.num_cpus
  memory   = var.memory

  
lifecycle {
    ignore_changes = [
      ept_rvi_mode,
      hv_mode,
      vapp[0].properties
    ]
  }
  cdrom {
    client_device = true
  }

  network_interface {
    network_id   = data.vsphere_network.this.id
  }
  wait_for_guest_net_timeout = 5

  disk {
    label            = "disk0"
    size             = 16
    controller_type  = "scsi"
  }

  clone {
    template_uuid = data.vsphere_content_library_item.my_ovf_item.id
  }

  provisioner "remote-exec" {
      inline = [
        "/bin/bash -c \"timeout 300 sed '/finished-user-data/q' <(tail -f /var/log/cloud-init-output.log)\"",
        "export KUBECONFIG=/home/ubuntu/.kube/config",
        "${var.execution_cmd}"
      ]
}

  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = tls_private_key.tls_private_key.private_key_pem
    host = self.default_ip_address
  }

  vapp {
    properties ={
      hostname = var.hostname
      public-keys = tls_private_key.tls_private_key.public_key_openssh
      user-data = base64encode(file("${path.module}/cloud-init/kickstart.yaml"))
    }
  }
  # don't use extra_config on with OVFs will be ignored
  extra_config = {
    # "guestinfo.metadata"          = base64encode(file("${path.module}/cloud-init/metadata.yaml"))
    # "guestinfo.metadata.encoding" = "base64"
    # "guestinfo.userdata"          = base64encode(file("${path.module}/cloud-init/userdata.yaml"))
    # "guestinfo.userdata.encoding" = "base64"
  }
}



 