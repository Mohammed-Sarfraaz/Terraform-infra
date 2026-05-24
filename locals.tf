locals {
  prefix      = lower("${var.project}-${var.environment}")
  location_tag = var.location
  common_tags = merge({
    project    = var.project
    environment = var.environment
    managed_by = "terraform"
  }, var.tags)
}
