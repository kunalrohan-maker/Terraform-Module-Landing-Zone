resource "azurerm_lb_backend_address_pool" "backendpool" {
  name            = each.value.name
  loadbalancer_id = data.azurerm_lb.lb[each.value.lb_id].id
  for_each = var.backendpool
}

data "azurerm_lb" "lb" {
  name                = each.value.name
  resource_group_name = each.value.res
  for_each = var.lb
}

resource "azurerm_network_interface_backend_address_pool_association" "bass" {
  network_interface_id    = data.azurerm_network_interface.NIC[each.value.NIC_id].id
  ip_configuration_name   = each.value.IP_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.backendpool[each.value.pool_id].id
  for_each = var.bass
}

data "azurerm_network_interface" "NIC" {
  for_each = var.NIC
  name                = each.value.name
  resource_group_name = each.value.res
}

