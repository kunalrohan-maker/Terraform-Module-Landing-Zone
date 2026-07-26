resource "azurerm_nat_gateway_public_ip_association" "NAT_pip" {
    for_each = var.NAT_pip
  nat_gateway_id       = data.azurerm_nat_gateway.NAT[each.value.nat_gateway_id].id
  public_ip_address_id = data.azurerm_public_ip.pip[each.value.public_ip_address_id].id

}

resource "azurerm_subnet_nat_gateway_association" "NAT_Subnet" {
  for_each = var.NAT_Subnet
  subnet_id      = data.azurerm_subnet.subnet[each.value.subnet_ids].id
  nat_gateway_id = data.azurerm_nat_gateway.NAT[each.value.nat_gateway_id].id
}


data "azurerm_public_ip" "pip" {
  for_each = var.pip
  name                = each.value.name
  resource_group_name = each.value.res
}

data "azurerm_nat_gateway" "NAT" {
    for_each = var.NAT
  name                = each.value.name
  resource_group_name = each.value.res
}

data "azurerm_subnet" "subnet" {
  name                 = each.value.name
  virtual_network_name = each.value.VNET
  resource_group_name  = each.value.res
  for_each = var.SN
}