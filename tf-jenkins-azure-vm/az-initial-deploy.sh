#!/bin/bash

# --- Configuration ---
# Set the names for your backend resources.
# The STORAGE_ACCOUNT_NAME must be globally unique across all of Azure.
# Use only lowercase letters and numbers.
RESOURCE_GROUP_NAME="tfstate-rg-jenkins"
STORAGE_ACCOUNT_NAME="tfstate$(openssl rand -hex 4)" # Appends a random 8-char hex string
CONTAINER_NAME="tfstate"
LOCATION="East US"

# --- Azure Login ---
# Ensure you are logged into the correct Azure subscription
az login
# az account set --subscription "Your-Subscription-Name-Or-ID"

# --- Create Resources ---
echo "Creating resource group: $RESOURCE_GROUP_NAME"
az group create --name $RESOURCE_GROUP_NAME --location "$LOCATION"

echo "Creating storage account: $STORAGE_ACCOUNT_NAME"
az storage account create \
  --name $STORAGE_ACCOUNT_NAME \
  --resource-group $RESOURCE_GROUP_NAME \
  --location "$LOCATION" \
  --sku Standard_LRS \
  --encryption-services blob

echo "Creating blob container: $CONTAINER_NAME"
az storage container create \
  --name $CONTAINER_NAME \
  --account-name $STORAGE_ACCOUNT_NAME

# --- Output ---
echo "----------------------------------------------------"
echo "Azure backend successfully created. Use these values in your backend.tf:"
echo "resource_group_name  = \"$RESOURCE_GROUP_NAME\""
echo "storage_account_name = \"$STORAGE_ACCOUNT_NAME\""
echo "container_name       = \"$CONTAINER_NAME\""
echo "----------------------------------------------------"

