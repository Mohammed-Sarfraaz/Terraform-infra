variable "project" {
  description = "Short project identifier used in names"
  type        = string
  default     = "aksdemo"
}

variable "environment" {
  description = "Deployment environment (dev/test/prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region to deploy resources into"
  type        = string
  default     = "Canada Central"
}

variable "tags" {
  description = "Map of tags applied to resources"
  type        = map(string)
  default     = {}
}

variable "node_count" {
  description = "Default node count for AKS system pool"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "min_count" {
  description = "Autoscaler minimum node count"
  type        = number
  default     = 1
}

variable "max_count" {
  description = "Autoscaler maximum node count"
  type        = number
  default     = 3
}
