module "resource_group" {
    source = "../../Child/azurerm_resource_group"
    RGs = var.RGs
  
}

module "VNET" {
    source ="../../Child/azurerm_virtual_network"
    VNET = var.VNET
    depends_on = [ module.resource_group ]
  
}

module "SN" {
    source = "../../Child/azurerm_subnet"
    SN = var.SN
    depends_on = [ module.VNET ]
  
}