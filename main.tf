module "resource_group" {
  source   = "./modules/resource-group"
  name     = "rg-${local.prefix}-${replace(lower(var.location), " ", "") }"
  location = var.location
  tags     = local.common_tags
}

module "networking" {
  source              = "./modules/networking"
  resource_group_name = module.resource_group.name
  location            = var.location
  vnet_name           = "vnet-${local.prefix}"
  address_space       = ["10.0.0.0/16"]
  subnet_name         = "snet-aks-${local.prefix}"
  subnet_prefix       = "10.0.1.0/24"
  tags                = local.common_tags
}

module "acr" {
  source              = "./modules/acr"
  name                = "acreg${replace(local.prefix, "-", "") }"
  resource_group_name = module.resource_group.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
  tags                = local.common_tags
}

module "aks" {
  source              = "./modules/aks"
  name                = "aks-${local.prefix}"
  resource_group_name = module.resource_group.name
  location            = var.location
  dns_prefix          = "aks-${local.prefix}"
  node_count          = var.node_count
  vm_size             = var.vm_size
  min_count           = var.min_count
  max_count           = var.max_count
  vnet_subnet_id      = module.networking.subnet_id
  acr_id              = module.acr.id
  tags                = local.common_tags
}
