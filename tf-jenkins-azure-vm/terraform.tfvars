# terraform.tfvars - Input variables for the Azure DevOps Agent VM
# ----------------------------------------------------------------
# This file is used to provide values for the variables defined in variables.tf.
# Uncomment and modify the values below to customize your deployment.
# Any variable not defined here will use its default value from variables.tf.

# General Settings
resource_group_name          = "rg-jenkins-server"
azurerm_storage_account_name = "jenkins"
location                     = "East US"
environment                  = "dev"
project_name                 = "jenkins-server"

# Network Variables
vnet_name               = "vnet-pool-agent"
vnet_address_space      = ["10.10.0.0/16"]
subnet_name             = "snet-pool-agent"
subnet_address_prefixes = ["10.10.1.0/24"]

# IMPORTANT: For security, replace the placeholder with your actual public IP address.

allowed_ssh_ips = ["174.88.134.251/32"]

# VM Variables
vm_name        = "vm-jenkins-server"
vm_size        = "Standard_B2s"
admin_username = "azureuser"

# ACR access permission
acr_name_for_permissions = "acr-aks-cicd-dev2439369"
