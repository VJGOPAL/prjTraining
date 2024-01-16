# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg_gvk" {
  name     = "rs_vgo058"
  location = "West Europe"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet_gvk" {
  name                = "vnet_vgo058"
  resource_group_name = azurerm_resource_group.rg_gvk.name
  location            = azurerm_resource_group.rg_gvk.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet_gvk" {
  name                 = "subnet_vgo058"
  resource_group_name  = azurerm_resource_group.rg_gvk.name
  virtual_network_name = azurerm_virtual_network.vnet_gvk.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic_gvk" {
  name                = "nic_vgo058"
  location            = azurerm_resource_group.rg_gvk.location
  resource_group_name = azurerm_resource_group.rg_gvk.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.subnet_gvk.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm_gvk" {
  name                  = "VMvgo058"
  location              = azurerm_resource_group.rg_gvk.location
  resource_group_name   = azurerm_resource_group.rg_gvk.name
  network_interface_ids = [azurerm_network_interface.nic_gvk.id]
  size                  = "Standard_B2s"

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  os_disk {
    name                 = "osdisk-vgo058"0
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_username                  = "vgo058"
  admin_password                  = "Password1234!"
  disable_password_authentication = false

}



