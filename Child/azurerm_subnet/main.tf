resource "azurerm_subnet" "SN" {
    name = each.value.name
    virtual_network_name = each.value.VNET
    resource_group_name = each.value.res
    address_prefixes = each.value.adf
    for_each = var.SN
  
}