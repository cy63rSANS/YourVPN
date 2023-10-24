locals {
  userdata = base64encode(file("./cloud-init/headscaleBasic.txt"))
}

resource "random_string" "vmpassword" {
  length           = 14
  special          = true
  numeric          = true
  upper            = true
}

resource azurerm_network_interface vpnhost {
	 name = "VPNhost"
	 location = var.Location
	 resource_group_name = var.ResG
	 enable_ip_forwarding = false
	 enable_accelerated_networking  = false
	 ip_configuration {
		 name = "VPNhost"
		 subnet_id = "${azurerm_subnet.VPNext.id}"
		 private_ip_address = "172.20.0.200"
		 private_ip_address_allocation = "Static"
		 primary = true
		 public_ip_address_id = "${azurerm_public_ip.VPNpip.id}"
		}
	tags = { 
	    Environment = var.Environment
	    Author = "Cy63rSi"
	} 
}

resource "azurerm_virtual_machine" "vpnhost" {
  name                = "VPNhost"
  resource_group_name = var.ResG
  location            = var.Location
  vm_size             = "Standard_B2s"
  network_interface_ids =  [azurerm_network_interface.vpnhost.id]
  
  os_profile_linux_config {
    disable_password_authentication = false
  }

  os_profile {
    computer_name = "VPNhost"
    admin_username = "netadmin"
    admin_password = "${random_string.vmpassword.id}"
    custom_data = local.userdata
  }

  storage_os_disk {
      name          = "webserver"
      create_option = "FromImage"
      disk_size_gb  = "32"
      os_type       = "Linux"
      caching       = "ReadWrite"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "22.04.202204200"
  }

}
output "vm_password" {
  value = random_string.vmpassword.id
}