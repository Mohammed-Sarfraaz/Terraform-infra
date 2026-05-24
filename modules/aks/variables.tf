variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "node_count" {
  type = number
}

variable "vm_size" {
  type = string
}

variable "enable_auto_scaling" {
  type    = bool
  default = true
}

variable "min_count" {
  type    = number
  default = 1
}

variable "max_count" {
  type    = number
  default = 3
}

variable "vnet_subnet_id" {
  type = string
}

variable "acr_id" {
  type = string
}

variable "log_analytics_workspace_id" {
  type    = string
  default = null
}

variable "service_cidr" {
  description = "Service CIDR range for AKS. Must not overlap VNet address space or AKS subnet."
  type        = string
  default     = "10.2.0.0/24"
}

variable "dns_service_ip" {
  description = "DNS service IP within the AKS service CIDR"
  type        = string
  default     = "10.2.0.10"
}

variable "tags" {
  type    = map(string)
  default = {}
}
