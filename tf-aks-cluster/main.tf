# main.tf tf-aks-cluster Root module
# Create a dedicated resource group for the AKS cluster

resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location
}

# Create the AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "${var.cluster_name}-dns"
  kubernetes_version  = var.kubernetes_version
  default_node_pool {
    name       = "default"
    node_count = var.system_node_count
    vm_size    = var.node_vm_size
    # Enable auto-scaling for cost-efficiency and performance
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 3
  }

# Use a system-assigned managed identity for simplicity and security
  identity {
    type = "SystemAssigned"
  }

# Configure SSH access to the cluster nodes
  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      key_data = file(var.ssh_public_key_path)
    }
  }

  tags = {
    environment = "dev"
    project     = "aks-cicd"
  }
}

# Create an ACR to store Docker images

resource "azurerm_container_registry" "acr" {
  name = var.acr_name
  resource_group_name = azurerm_resource_group.aks.name
  location = azurerm_resource_group.aks.location
  sku = "Basic"
  admin_enabled = false # use role-based access instead of admin user

  tags = {
    environment = "dev"
    project = "aks-cicd"
  }
}

# Grant the AKS Cluster's identity permission to pull images from the ACR.
resource "azurerm_role_assignment" "aks_pull_from_acr" {
  scope = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}


