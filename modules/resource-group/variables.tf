variable "name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Location for the resource group"
  type        = string
}

variable "tags" {
  description = "Tags for the resource group"
  type        = map(string)
  default     = {}
}
