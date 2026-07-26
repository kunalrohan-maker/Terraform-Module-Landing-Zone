resource "azurerm_network_security_group" "NSG" {
    for_each = var.NSG
  name                = each.value.name
  location            = each.value.loc
  resource_group_name = each.value.res

  security_rule {
    name                       = each.value.name_security_rule
    priority                   = each.value.priority
    direction                  = each.value.direction
    access                     = each.value.access
    protocol                   = each.value.protocol
    source_port_range          = "*"
    destination_port_range     = each.value.destination_port_range
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }  

  }