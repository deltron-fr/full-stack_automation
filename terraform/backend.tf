terraform {
  backend "azurerm" {
    resource_group_name  = var.blob_resource_group
    storage_account_name = var.blob_storage_account
    container_name       = var.blob_container
    key                  = var.blob_key
  }
}