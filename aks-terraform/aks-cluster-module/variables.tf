variable "aks_cluster_name" {
  description = "value"
  type        = string
}

variable "cluster_location" {
  description = "value"
  type        = string
}

variable "dns_prefix" {
  description = "value"
  type        = string
}

variable "kubernetes_version" {
  description = "value"
  type        = string
}

variable "service_principal_client_id" {
  description = "value"
  type        = string
}

variable "service_principal_client_secret" {
  description = "value"
  type        = string
}

# Input variables from the networking module
variable "resource_group_name" {
  description = "value"
  type        = string
}

variable "vnet_id" {
  description = "value"
  type        = string
}

variable "control_plane_subnet_id" {
  description = "ID of the control plane subnet."
  type        = string
}

variable "worker_node_subnet_id" {
  description = "ID of the worker node subnet."
  type        = string
}

variable "aks_nsg_id" {
  description = "ID of the Network Security Group (NSG) for AKS."
  type        = string
}
