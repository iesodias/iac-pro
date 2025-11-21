variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-lab-azure-terraform"
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
  default     = "East US"
}