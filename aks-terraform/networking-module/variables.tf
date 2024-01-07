variable "resource_group_name" {
  description = "The name of the cloud resource group in which the networking resources will be created."
  type        = string
}

variable "location" {
  description = "The geographic location where the networking resources will be deployed."
  type        = string
}

variable "vnet_address_space" {
  description = "Defines the IP address range for the Virtual Network (VNet) in CIDR notation. It's a list to allow multiple ranges."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "public_ip_address" {
  description = "Specifies the public IP address to be associated with a resource such as a load balancer or VM instance."
  type        = string
}
