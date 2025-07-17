# acr_permissions.tf - tf-jenkins-azure-vm Root module
# This file handles giving the Jenkins VM permission to interact with the ACR.

data "azurerm_resource_group" "aks_rg" {
  name = "rg-aks-clsuter"
}

data "azurerm_container_registry" "acr" {
  name = var.acr_name_for_permissions
  resource_group_name = data.azurerm_resource_group.aks_rg.name
}

resource "azurerm_role_assignment" "jenkins_push_to_acr" {
  scope = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPush"
  principal_id = module.vm.vm_principal_id
}
