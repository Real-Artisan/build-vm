resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_resource_group" "spacemonkey" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "spacemonkey" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.spacemonkey.location
  resource_group_name = azurerm_resource_group.spacemonkey.name
  address_space       = [var.ip_range]
}

resource "azurerm_subnet" "spacemonkey" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.spacemonkey.name
  virtual_network_name = azurerm_virtual_network.spacemonkey.name
  address_prefixes     = ["${azurerm_virtual_network.spacemonkey.address_space[0]}/24"]
}

resource "azurerm_network_interface" "spacemonkey" {
  name                = "nic1"
  location            = azurerm_resource_group.spacemonkey.location
  resource_group_name = azurerm_resource_group.spacemonkey.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.spacemonkey.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "spacemonkey" {
  name                = var.virtual_machine_hostname
  location            = azurerm_resource_group.spacemonkey.location
  resource_group_name = azurerm_resource_group.spacemonkey.name

  size                 = "Standard_DS2_v2"
  admin_username       = "adminuser"
  disable_password_authentication = true

  admin_ssh_key {
    username       = "adminuser"
    public_key = tls_private_key.example_ssh.public_key_openssh
  }

  os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb      = 30
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }

  source_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = 30
  }

  network_interface_ids = [azurerm_network_interface.spacemonkey.id]
}
