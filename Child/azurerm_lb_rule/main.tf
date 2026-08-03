resource "azurerm_lb_rule" "http" {

  loadbalancer_id = data.azurerm_lb.lb[each.value.lb_id].id

  name = each.value.name

  protocol = each.value.proto

  frontend_port = 80

  backend_port = 80

  frontend_ip_configuration_name = each.value.frontendIP_config

  backend_address_pool_ids = [
    data.azurerm_lb_backend_address_pool.backendpool[each.value.pool_id].id
  ]

  probe_id = azurerm_lb_probe.healthprobe[each.value.probe_id].id

  for_each = var.rule
}

data "azurerm_lb" "lb" {
  name                = each.value.name
  resource_group_name = each.value.res
  for_each = var.lb
}

resource "azurerm_lb_probe" "healthprobe" {
  loadbalancer_id = data.azurerm_lb.lb[each.value.lb_id].id
  name            = each.value.name
  port            = each.value.port
  for_each = var.health
}


data "azurerm_lb_backend_address_pool" "backendpool" {
  name            = each.value.name
  loadbalancer_id = data.azurerm_lb.lb[each.value.lb_id].id
  for_each = var.backendpool

}