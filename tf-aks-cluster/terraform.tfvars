# terraform.tfvars tf-aks-cluster Root module

cluster_name = "aks-dev-cluster"
node_vm_size = "Standard_B2s"
system_node_count = 2
kubernetes_version = "1.30.1"
acr_name = "acr-aks-cicd-dev2439369"
