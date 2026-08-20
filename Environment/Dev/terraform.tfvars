RG = {
  RG1 = {
    name    = "Prod_Rohan"
    loc     = "New Zealand North"
    managed = "Rohan"
  }
  RG2 = {
    name    = "Prod_Kunal"
    loc     = "New Zealand North"
    managed = "Kunal"
  }
}

VNET = {
  V1 = { name = "Virtual_VM", loc = "New Zealand North", res = "Prod_Rohan", add = ["10.0.0.0/16"] }
  V2 = { name = "Virtual_NZ", loc = "New Zealand North", res = "Prod_Kunal", add = ["192.168.0.0/16"] }
}

SN = {
  S1 = { name = "frontend", res = "Prod_Rohan", VNET = "Virtual_VM", adf = ["10.0.1.0/24"] }
  S2 = { name = "backtend", res = "Prod_Rohan", VNET = "Virtual_VM", adf = ["10.0.2.0/24"] }
  S3 = { name = "Database", res = "Prod_Rohan", VNET = "Virtual_VM", adf = ["10.0.3.0/24"] }
  S4 = { name = "AzureBastionSubnet", res = "Prod_Rohan", VNET = "Virtual_VM", adf = ["10.0.4.0/28"] }
  S5 = { name = "frontend", res = "Prod_Kunal", VNET = "Virtual_NZ", adf = ["192.168.1.0/24"] }
  S6 = { name = "Backend", res = "Prod_Kunal", VNET = "Virtual_NZ", adf = ["192.168.2.0/24"] }
  S7 = { name = "Database", res = "Prod_Kunal", VNET = "Virtual_NZ", adf = ["192.168.3.0/24"] }
  S8 = { name = "AzureBastionSubnet", res = "Prod_Kunal", VNET = "Virtual_NZ", adf = ["192.168.4.0/28"] }
}

pip = {
  pip1 = { name = "BastionIP", res = "Prod_Rohan", loc = "New Zealand North", allo = "Static" }
  pip2 = {name = "NAT_IP", res = "Prod_Rohan", loc = "New Zealand North", allo = "Static"} 
  pip3 = { name = "LB_IP", res = "Prod_Rohan", loc = "New Zealand North", allo = "Static"}
}

bastion = {

  bastion1 = { name = "Azure_Bastion", res = "Prod_Rohan", loc = "New Zealand North", ip = "Bastion_IP", subnet_id = "S4", public_ip_address_id = "pip1" }
}

NAT = {
  NAT1 = {name = "NAT", loc = "New Zealand North", res = "Prod_Rohan", public_ip_address_id = "pip2", sku = "Standard"}
}

NAT_Subnet = {
  NAT_Subnet1 = {nat_gateway_id = "NAT1",subnet_ids = "S1" }
  NAT_Subnet2 = {nat_gateway_id = "NAT1",subnet_ids = "S2" }
  NAT_Subnet3 = {nat_gateway_id = "NAT1",subnet_ids = "S3" }
}

NAT_pip = {
  NAT_pip1 = {nat_gateway_id = "NAT1", public_ip_address_id = "pip2"}
}

NSG = {
  NSG1 = {name = "NSG_Frontend", loc = "New Zealand North", res = "Prod_Rohan", name_security_rule = "ProdOps", priority = 100,direction = "Inbound", access = "Allow",
    protocol = "Tcp",destination_port_range  = "22"}
  NSG2 = {name = "NSG_Backend", loc = "New Zealand North", res = "Prod_Rohan", name_security_rule = "ProdOps", priority = 100, direction = "Inbound", access = "Allow",
    protocol = "Tcp",destination_port_range  = "22"}
}

NIC = {
  NIC1 ={name = "NIC_Frontend",loc = "New Zealand North",res = "Prod_Rohan",IP_name = "frontend_privateIP", allocation = "Dynamic",subnet_id = "S1",NSG_id = "NSG1"}
  NIC2 ={name = "NIC_Backend",loc = "New Zealand North",res = "Prod_Rohan",IP_name = "backend_privateIP", allocation = "Dynamic",subnet_id = "S2", NSG_id = "NSG2"}
 }

 VM = {
  VM1 = {name = "frontendVM",res = "Prod_Rohan", loc = "New Zealand North",size = "Standard_D2ls_v5",admin_username = "test123456", admin_password = "Test_123456789",
  disable_password_authentication = false, caching = "ReadWrite", storage_account_type = "Standard_LRS", publisher = "Canonical", offer = "UbuntuServer",
  sku = "16.04-LTS", version = "latest", NIC_id = "NIC1"}
  VM2 = {name = "backendVM",res = "Prod_Rohan",loc = "New Zealand North",size = "Standard_D2ls_v5",admin_username = "test123456", admin_password = "Test_123456789",
  disable_password_authentication = false, caching = "ReadWrite", storage_account_type = "Standard_LRS", publisher = "Canonical", offer = "UbuntuServer",
  sku = "16.04-LTS", version = "latest", NIC_id = "NIC2"}

 }


 lb = {
  lb1 = { name = "LoadBalancer",loc = "New Zealand North", res= "Prod_Rohan", frontendIP_config = "LB_IP", public_ip_address_id = "pip3"}
 }

 health = {
  h1 = { name = "HealthProbe", port = 22, lb_id = "lb1"}
 }

 backendpool = {
  pool1 = {name = "Backendpool", lb_id="lb1"}
 }

 bass = {
  bass1 = { IP_name = "frontend_privateIP", NIC_id = "NIC1", pool_id = "pool1"}
  bass2 = { IP_name = "backend_privateIP", NIC_id = "NIC2", pool_id = "pool1"}
 }

 rule = {
  rule1 = {name = "HTTP", proto = "Tcp", frontendIP_config = "LB_IP", pool_id = "pool1", probe_id = "h1", lb_id = "lb1"}
 }
