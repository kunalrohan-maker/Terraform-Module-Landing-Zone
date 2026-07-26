resource "azurerm_linux_virtual_machine" "VM" {
    for_each = var.VM
  name                = each.value.name
  resource_group_name = each.value.res
  location            = each.value.loc
  size                = each.value.size
  admin_username      = each.value.admin_username
  admin_password =      each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication
  network_interface_ids = [ data.azurerm_network_interface.NIC[each.value.NIC_id].id]

    os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}

data "azurerm_network_interface" "NIC" {
  for_each = var.NIC
  name                = each.value.name
  resource_group_name = each.value.res
}