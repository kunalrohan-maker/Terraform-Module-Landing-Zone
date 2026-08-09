module "resource_group" {
  source = "../../Child/azurerm_resource_group"
  RGs    = var.RG

}

module "VNET" {
  source     = "../../Child/azurerm_virtual_network"
  VNET       = var.VNET
  depends_on = [module.resource_group]

}

module "SN" {
  source     = "../../Child/azurerm_subnet"
  SN         = var.SN
  depends_on = [module.VNET]

}

module "publicIP" {
  source     = "../../Child/azurerm_publicIP"
  pip        = var.pip
  depends_on = [module.resource_group]
}

module "bastion_host" {
  source     = "../../Child/azurerm_Bastion_host"
  bastion    = var.bastion
  pip        = var.pip
  SN         = var.SN
  depends_on = [module.publicIP, module.SN,module.resource_group]

}

module "NAT" {
  source = "../../Child/azurerm_NAT_Gateway"
  NAT = var.NAT
  
  
  depends_on = [ module.publicIP,module.resource_group,module.SN ]
  
}

module "NAT_Ass" {
  source = "../../Child/azurerm_subnet_nat_gateway_association"
NAT_Subnet = var.NAT_Subnet
pip = var.pip
SN = var.SN
NAT = var.NAT
NAT_pip = var.NAT_pip
depends_on = [ module.NAT, module.SN, module.publicIP]
  
}

module "NSG" {
  source = "../../Child/azurerm_network_security_group"
  NSG = var.NSG
  depends_on = [ module.resource_group ]
}

module "NIC" {
  source = "../../Child/azurerm_network_interface"
  NIC = var.NIC
  SN = var.SN
  NSG = var.NSG
  depends_on = [ module.resource_group, module.SN, module.NSG ]
}

module "VM" {
  source = "../../Child/azurerm_linux_virtual_machine"
  VM = var.VM
  NIC = var.NIC
  depends_on = [ module.resource_group, module.NIC ]
  
}

module "lb" {
  source = "../../Child/azurerm_loadbalancer"
  lb = var.lb
  pip = var.pip
  depends_on = [ module.publicIP ]
  
}


module "Backend" {
  source = "../../Child/azurerm_backend_pool"
  backendpool = var.backendpool
  bass = var.bass
  lb = var.lb
  NIC = var.NIC
  depends_on = [ module.lb ]
  
}

module "rule" {
  source = "../../Child/azurerm_lb_rule"
  rule = var.rule
  health = var.health
  backendpool = var.backendpool
  lb = var.lb
  depends_on = [ module.lb, module.Backend ]
  
}



