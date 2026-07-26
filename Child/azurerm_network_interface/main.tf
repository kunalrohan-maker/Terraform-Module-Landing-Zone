resource "azurerm_network_interface" "NIC" {
    for_each = var.NIC
  name                = each.value.name
  location            = each.value.loc
  resource_group_name = each.value.res

  ip_configuration {
    name                          = each.value.IP_name
    subnet_id                     = data.azurerm_subnet.subnet[each.value.subnet_id].id
    private_ip_address_allocation = each.value.allocation
  }

}

data "azurerm_subnet" "subnet" {
  name                 = each.value.name
  virtual_network_name = each.value.VNET
  resource_group_name  = each.value.res
  for_each = var.SN
}

resource "azurerm_network_interface_security_group_association" "NSG_NIC_Ass" {
  for_each = var.NIC
  network_interface_id      = azurerm_network_interface.NIC[each.key].id
  network_security_group_id = data.azurerm_network_security_group.NSG[each.value.NSG_id].id
}

data "azurerm_network_security_group" "NSG" {
  for_each = var.NSG
  name                = each.value.name
  resource_group_name = each.value.res
}