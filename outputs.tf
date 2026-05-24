output "resource_group_name" {
  description = "Resource Group name"
  value       = module.resource_group.name
}

output "acr_login_server" {
  description = "ACR login server"
  value       = module.acr.login_server
}

output "aks_name" {
  description = "AKS cluster name"
  value       = module.aks.name
}

