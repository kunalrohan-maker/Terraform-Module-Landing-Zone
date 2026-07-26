resource "azurerm_nat_gateway" "NAT" {
    for_each = var.NAT
  name                = each.value.name
  location            = each.value.loc
  resource_group_name = each.value.res
  sku_name            = each.value.sku
}

