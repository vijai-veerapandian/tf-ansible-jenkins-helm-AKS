# output.tf tf-aks-cluster Root module

output "resource_group_name" {
  description = "The name of the resource group where the AKS cluster is deployed."
  value       = azurerm_resource_group.aks.name
}

output "cluster_name" {
  description = "The name of the deployed AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.name
}

output "kube_config" {
  description = "The Kubernetes configuration file to connect to the cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "acr_name" {
  description = "The name of the azure container registry."
  value = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  description = "The FQDN of the azure container registry."
  value = azurerm_container_registry.acr.login_server
}
