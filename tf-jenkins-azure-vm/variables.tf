# variables.tf - Root module variables

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-jenkins-server"
}

variable "azurerm_storage_account_name" {
  description = "Prefix for the storage account name(will be combined with random suffix)"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "East US"

  validation {
    condition = contains([
      "East US", "East US 2", "West US", "West US 2", "West US 3",
      "Central US", "North Central US", "South Central US", "West Central US",
      "Canada Central", "Canada East"
    ], var.location)
    error_message = "Location must be a valid Azure region"
  }
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = can(regex("^(dev|staging|prod)$", var.environment))
    error_message = "Environment must be one of: dev, staging, or prod."
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "jenkins-server"
}

# NW Variables
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet-jenkins-server"
}


variable "vnet_address_space" {
  description = "Address space for the virtual machine"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "subnet-jenkins-server"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}


variable "allowed_ssh_ips" {
  description = "List of IP address/CIDR blocks allowed to ssh to the VM"
  type        = list(string)
  # Removing the default makes this a required variable, preventing accidental
  # exposure of the VM to the entire internet. This is a security best practice.
}

#VM Variables

variable "vm_name" {
  description = "Name of the VM"
  type        = string
  default     = "vm-jenkins-server"
}

variable "vm_size" {
  description = "size of the VM"
  type        = string
  default     = "Standard_B2s" # 2 vCPUs, 4GB RAM - optimal for devops pool agent

  validation {
    condition = contains([
      "Standard_B1s", "Standard_B1ms", "Standard_B2s", "Standard_B2ms",
      "Standard_B4ms", "Standard_D2s_v3", "Standard_D4s_v3"
    ], var.vm_size)
    error_message = "VM size must be one of the supported sizes for pool agents."
  }
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"

  validation {
    condition     = can(regex("^[a-z][a-z0-9_]*$", var.admin_username))
    error_message = "Admin username must meet this condition"
  }
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
  default     = "./.ssh/ssh-key-aks-cluster-ubuntu.pub"

  validation {
    condition     = fileexists(var.ssh_public_key_path)
    error_message = "Specified SSH public key file doesn't exist at the provided path."
  }
}

variable "acr_name_for_permissions" {
  description = "The name of the Azure container registry to grant push permissions"
  type = string
}
