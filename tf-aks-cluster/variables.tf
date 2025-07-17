# variables.tf tf-aks-cluster Root module

variable "resource_group_name" {
  description = "Name of the resource group for AKS."
  type        = string
  default     = "rg-aks-cluster"
}

variable "location" {
  description = "Azure region where the AKS cluster will be created."
  type        = string
  default     = "East US"
}

variable "cluster_name" {
  description = "The name for the AKS cluster."
  type        = string
  default     = "aks-dev-cluster"
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the cluster."
  type        = string
  default     = "1.30.1" # It's good practice to pin the version
}

variable "system_node_count" {
  description = "The number of nodes in the default system node pool."
  type        = number
  default     = 2
}

variable "node_vm_size" {
  description = "The VM size for the AKS nodes."
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Admin username for the nodes."
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key file to access nodes."
  type        = string
  # Pointing to the same key used for the Jenkins VM for consistency.
  default     = "../tf-jenkins-azure-vm/.ssh/ssh-key-aks-cluster-ubuntu.pub"

  validation {
    condition     = fileexists(var.ssh_public_key_path)
    error_message = "Specified SSH public key file doesn't exist at the provided path."
  }
}

variable "acr_name" {
  description = "The globally unique name for the acr, use only lowercase letters and numbers."
  type = string
}
