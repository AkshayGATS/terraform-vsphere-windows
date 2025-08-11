variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}

variable "datacenter" {
  default = "MES_POC"
}

variable "cluster" {
  default = "MES_POC"
}

variable "template_name" {
  default = "Test-Win-Template"
}

variable "vm_name" {}
variable "vm_cpu" {
  default = 2
}
variable "vm_memory" {
  default = 4096
}
variable "vm_disk_size" {
  default = 40
}
variable "vm_network" {
  default = "VM Network"
}
variable "vm_ip" {}
variable "vm_gateway" {}
variable "vm_dns" {
  default = ["8.8.8.8"]
}
variable "vm_subnet_mask" {}
