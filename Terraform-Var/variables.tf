variable "location" {
    default =  "West Europe"
    type = string
}

variable "resource_group_name" {
    default = "rg_vgo058"
    type = string
}
variable "vnet" {
    type = string
    default = "vnet_vgo058"
}
variable "subnet" {
    type = string
    default = "subnet_vgo058"
}
variable "nic" {
    type = string
    default = "nic_vgo058"
}
variable "vmname" {
    type = string
    default = "vmvgo058"
}
variable "os_disk_name" {
    type = string
    default = "os_dsk_vgo058"
}
variable "admin_user" {
    type = string
    default = "admin_vgo058"
}
variable "admin_pwd" {
    default = "Password1234!"
    type = string
    sensitive = true
}


