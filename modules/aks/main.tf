data "azurerm_role_definition" "acr_pull" {
  name = "AcrPull"
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_prefix = var.dns_prefix

  default_node_pool {
    name            = "system"
    node_count      = var.node_count
    vm_size         = var.vm_size
    vnet_subnet_id  = var.vnet_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    service_cidr      = var.service_cidr
    dns_service_ip    = var.dns_service_ip
  }

  # RBAC and monitoring addons can be configured per-environment. Add blocks
  # here or via module variables when needed.

  tags = var.tags
}

resource "azurerm_role_assignment" "acr_pull" {
  scope              = var.acr_id
  role_definition_id = data.azurerm_role_definition.acr_pull.id
  principal_id       = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}
