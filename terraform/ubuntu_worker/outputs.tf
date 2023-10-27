output "default_ip_address" {
  value       = vsphere_virtual_machine.this.default_ip_address
  description = "The name of the Auto Scaling Group"
}

resource "local_file" "private_key" {
  content         = tls_private_key.tls_private_key.private_key_pem
  filename        = "tls_private_key.pem"
  file_permission = "0600"
}