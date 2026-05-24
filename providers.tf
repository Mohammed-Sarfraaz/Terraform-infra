provider "azurerm" {
  features {}
}

# Backend intentionally omitted for local development. To enable a remote
# azurerm backend, add a backend configuration to `backend.tf` or uncomment
# and populate the backend block with your storage account details.
