resource "azurerm_bastion_host" "bastion" {
    for_each = var.bastion
  name                = each.value.name
  location            = each.value.loc
  resource_group_name = each.value.res

  ip_configuration {
    
    name                 = each.value.ip
    subnet_id            = data.azurerm_subnet.subnet[each.value.subnet_id].id
    public_ip_address_id = data.azurerm_public_ip.pip[each.value.public_ip_address_id].id
    }
}

data "azurerm_public_ip" "pip" {
  for_each = var.pip
  name                = each.value.name
  resource_group_name = each.value.res
}

data "azurerm_subnet" "subnet" {
  name                 = each.value.name
  virtual_network_name = each.value.VNET
  resource_group_name  = each.value.res
  for_each = var.SN
}

