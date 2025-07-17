# tf-ansible-jenkins-helm-AKS
Terraform-Ansible-Jenkins-Helm-AKS all integrated DevOps CI/CD project

# know ur public ip address

curl ifconfig.me





```
# Ansible playbook execution
cd ansible-for-jenkins

update the inventory/inventory.tpl file with the azureVM IP address and then run the playbook
```
ansible-playbook -vvv playbook.yml
```

# Use the same command from earlier to connect
```
ssh -i ../.ssh/ssh-key-aks-cluster-ubuntu azureuser@<YOUR_VM_IP_ADDRESS>

# Once on the server, get the password
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```


# AKS cluster

```
cd tf-aks-cluster
terraform init
terraform validate
terraform plan -out=aksversion1.tfplan
terraform apply aksversion1.tfplan
```

### Access the cluster

```
terraform output -raw kube_config > kube_config_aks

export KUBECONFIG=$(pwd)/kube_config_aks
kubectl get nodes
```