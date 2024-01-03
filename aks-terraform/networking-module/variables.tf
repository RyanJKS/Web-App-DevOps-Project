# networking-module/variables.tf

variable "resource_group_name" {
  description = "value"
  type        = string
}

variable "location" {
  description = "value"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network (VNet)."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "public_ip_address" {
  description = "value"
  type        = string
}
