resource "azurerm_public_ip" "pip" {
  name                = each.value.name
  resource_group_name = each.value.res
  location            = each.value.loc
  allocation_method   = each.value.allo
  for_each = var.pip
}