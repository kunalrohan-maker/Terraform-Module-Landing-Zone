resource "azurerm_lb" "loadbalancer" {
    for_each = var.lb
  name                = each.value.name
  location            = each.value.loc
  resource_group_name = each.value.res

  frontend_ip_configuration {
    name                 = each.value.frontendIP_config
    public_ip_address_id = data.azurerm_public_ip.pip[each.value.public_ip_address_id].id
  }
}

data "azurerm_public_ip" "pip" {
  for_each = var.pip
  name                = each.value.name
  resource_group_name = each.value.res
}