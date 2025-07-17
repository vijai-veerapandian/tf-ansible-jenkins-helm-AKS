# backend.tf
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg-jenkins"
    storage_account_name = "tfstate34032550"
    container_name       = "tfstate"
    key                  = "jenkins-vm.terraform.tfstate"
  }
}

