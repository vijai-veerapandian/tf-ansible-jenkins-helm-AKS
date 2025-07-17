# main.tf - Root module for Virtual Machine.
# Create Resource Group

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# Random string for additional uniqueness
resource "random_string" "suffix" {
  length  = 10
  special = false
  upper   = false
}

resource "azurerm_storage_account" "main" {
  name                     = "st${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# Network Module:

module "network" {
  source = "./modules/network"

  resource_group_name     = azurerm_resource_group.main.name
  location                = azurerm_resource_group.main.location
  vnet_name               = var.vnet_name
  vnet_address_space      = var.vnet_address_space
  subnet_name             = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
  allowed_ssh_ips         = var.allowed_ssh_ips
  environment             = var.environment

}

# VM Module

module "vm" {
  source = "./modules/vm"

  resource_group_name       = azurerm_resource_group.main.name
  location                  = azurerm_resource_group.main.location
  vm_name                   = var.vm_name
  vm_size                   = var.vm_size
  admin_username            = var.admin_username
  ssh_public_key_path       = var.ssh_public_key_path
  subnet_id                 = module.network.subnet_id
  network_security_group_id = module.network.network_security_group_id
  environment               = var.environment
}
