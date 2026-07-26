resource "azurerm_resource_group" "RG" {
    for_each = var.RGs
    name = each.value.name
    location = each.value.loc
  
}