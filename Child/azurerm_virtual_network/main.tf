resource "azurerm_virtual_network" "VNET" {
    name = each.value.name
    resource_group_name = each.value.res
    location = each.value.loc
    address_space = each.value.add
    for_each = var.VNET
  
}