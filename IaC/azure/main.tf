resource azurerm_resource_group VPN {
	name = var.ResG
	location = var.Location
		tags = { 
			Environment = var.Environment
			Author = "Cy63rSi"
			CreatedDate = timestamp()
		}
}

resource azurerm_virtual_network VPNnet {
	name = "VPNnet"
	location = var.Location
	resource_group_name = var.ResG
	depends_on = [azurerm_resource_group.VPN]
	address_space =  ["172.20.0.0/22",] #172.20.0.0-172.20.3.255	
		tags = { 
			Environment = var.Environment
			Author = "Cy63rSi"
		}	
}

resource azurerm_subnet VPNint {
	 name = "VPN-Int"
	 virtual_network_name = "VPNnet"
	 resource_group_name = var.ResG
	 address_prefixes = ["172.20.2.0/24"]
     depends_on = [azurerm_virtual_network.VPNnet]
	 service_endpoints = ["Microsoft.Web"]

}

resource azurerm_subnet VPNext {
	 name = "VPN-Ext"
	 virtual_network_name = "VPNnet"
	 resource_group_name = var.ResG
	 address_prefixes = ["172.20.0.0/24"]
	 service_endpoints = []
     depends_on = [azurerm_virtual_network.VPNnet]

} 

resource azurerm_public_ip VPNpip{
	 name = "VPNpip"
	 location = var.Location
	 resource_group_name = var.ResG
	 sku = "Basic"
	 allocation_method   = "Dynamic"
     depends_on = [azurerm_resource_group.VPN]
}





