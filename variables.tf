variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the resource group and virtual network"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "ip_range" {
  description = "IP range for the virtual network"
  type        = string
}

variable "virtual_machine_hostname" {
  description = "Hostname for the virtual machine"
  type        = string
}
