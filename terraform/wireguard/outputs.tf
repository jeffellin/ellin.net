output "default_ip_address" {
  value       = module.ubuntu_node.default_ip_address
  description = "The Default IP address for the new VM"
}



resource "random_pet" "pet" {
  length  = 2
  keepers = {
    instance_ip = module.ubuntu_node.default_ip_address
  }
}

output "qus" {
  value       = random_pet.pet.id
  description = "The Default IP address for the new VM"
}
