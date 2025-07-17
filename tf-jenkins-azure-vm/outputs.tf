# outputs.tf - Root module outputs

output "resource_group_name" {
  description = "Name of the craeted resource group"
  value       = var.resource_group_name
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.main.name
}

output "vm_name" {
  description = "The name of the azure VM."
  value       = var.vm_name
}

output "vm_public_ip" {
  description = "The public IP address of the azure VM."
  value       = module.vm.public_ip_address
}

output "vm_fqdn" {
  description = "The fully qualified domain name of the azure VM."
  value       = module.vm.fqdn
}

output "admin_username" {
  description = "The username of the azure VM to access"
  value = var.admin_username
}

output "ssh_connection_string" {
  description = "The command to connect to the VM using SSH."
  value       = "ssh ${var.admin_username}@${coalesce(module.vm.fqdn, module.vm.public_ip_address)}"
}

output "vm_management_commands" {
  description = "A map of useful Azure CLI commands to manage the VM's lifecycle."
  value       = local.vm_management_commands
}

output "cost_optimization_tips" {
  description = "Tips for optimizing the cost of this VM."
  value       = <<-EOT
    - The VM is configured with a ${var.vm_size} instance type.
    - To stop the VM manually and deallocate compute resources, run: '${local.vm_management_commands.stop}'
  EOT
}

output "vm_principal_id" {
  description = "The principal ID of the system-assigned managed identity for the VM. Use this to grant the VM access to other Azure resources."
  value       = module.vm.vm_principal_id
}
