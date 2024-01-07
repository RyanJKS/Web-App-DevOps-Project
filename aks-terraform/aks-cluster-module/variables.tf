variable "aks_cluster_name" {
  description = "The name of the Azure Kubernetes Service (AKS) cluster."
  type        = string
}

variable "cluster_location" {
  description = "The geographic location where the AKS cluster will be created (e.g., 'East US')."
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix which is used to create the fully qualified domain name (FQDN) for the AKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the AKS cluster."
  type        = string
}

variable "service_principal_client_id" {
  description = "The client ID of the Azure Service Principal associated with the AKS cluster."
  type        = string
}

variable "service_principal_client_secret" {
  description = "The client secret for the Azure Service Principal used by the AKS cluster."
  type        = string
}

# Input variables from the networking module
variable "resource_group_name" {
  description = "The name of the Azure resource group in which the AKS cluster and associated resources are located."
  type        = string
}

variable "vnet_id" {
  description = "The ID of the Azure Virtual Network (VNet) where the AKS cluster is deployed."
  type        = string
}

variable "control_plane_subnet_id" {
  description = "The ID of the subnet within the Azure VNet for the AKS cluster's control plane."
  type        = string
}

variable "worker_node_subnet_id" {
  description = "The ID of the subnet within the Azure VNet for the AKS cluster's worker nodes."
  type        = string
}

variable "aks_nsg_id" {
  description = "The ID of the Azure Network Security Group (NSG) associated with the AKS cluster."
  type        = string
}
