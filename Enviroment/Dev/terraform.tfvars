RG = {
  RG1 = {
    name    = "Dev_Rohan"
    loc     = "Japan east"
    managed = "Rohan"
  }
  RG2 = {
    name    = "Dev_Kunal"
    loc     = "Australia east"
    managed = "Kunal"
  }
}

VNET = {
  V1 = { name = "Virtual_JAPAN", loc = "Japaneast", res = "Dev_Rohan", add = ["10.0.0.0/16"] }
  V2 = { name = "Virtual_AUS", loc = "Australia east", res = "Dev_Kunal", add = ["192.168.0.0/16"] }
}

SN = {
  S1 = { name = "frontend", res = "Dev_Rohan", VNET = "Virtual_JAPAN", adf = ["10.0.1.0/24"] }
  S2 = { name = "backtend", res = "Dev_Rohan", VNET = "Virtual_JAPAN", adf = ["10.0.2.0/24"] }
  S3 = { name = "Database", res = "Dev_Rohan", VNET = "Virtual_JAPAN", adf = ["10.0.3.0/24"] }
  S4 = { name = "AzureBastionSubnet", res = "Dev_Rohan", VNET = "Virtual_JAPAN", adf = ["10.0.4.0/28"] }
  S5 = { name = "frontend", res = "Dev_Kunal", VNET = "Virtual_Aus", adf = ["192.168.1.0/24"] }
  S6 = { name = "Backend", res = "Dev_Kunal", VNET = "Virtual_Aus", adf = ["192.168.2.0/24"] }
  S7 = { name = "Database", res = "Dev_Kunal", VNET = "Virtual_Aus", adf = ["192.168.3.0/24"] }
  S8 = { name = "AzureBastionSubnet", res = "Dev_Kunal", VNET = "Virtual_Aus", adf = ["192.168.4.0/28"] }
}

pip = {
  pip1 = { name = "BastionIP", res = "Dev_Rohan", loc = "Japaneast", allo = "Static" }
  pip2 = {name = "NAT_IP", res = "Dev_Rohan", loc = "Japaneast", allo = "Static"} 
  pip3 = { name = "frontendIP", res = "Dev_Rohan", loc = "Japaneast", allo = "Static"}
}

bastion = {

  bastion1 = { name = "Azure_Bastion", res = "Dev_Rohan", loc = "Japaneast", ip = "Bastion_IP", subnet_id = "S4", public_ip_address_id = "pip1" }
}

NAT = {
  NAT1 = {name = "NAT", loc = "Japaneast", res = "Dev_Rohan", public_ip_address_id = "pip2", sku = "Standard"}
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
  NSG1 = {name = "NSG_Frontend", loc = "Japaneast", res = "Dev_Rohan", name_security_rule = "DevOps", priority = 100,direction = "Inbound", access = "Allow",
    protocol = "Tcp",destination_port_range  = "22"}
  NSG2 = {name = "NSG_Backend", loc = "Japaneast", res = "Dev_Rohan", name_security_rule = "DevOps", priority = 100,direction = "Inbound", access = "Allow",
    protocol = "Tcp",destination_port_range  = "22"}  
}

NIC = {
  NIC1 ={name = "NIC_Frontend",loc = "Japaneast",res = "Dev_Rohan",IP_name = "frontend_IP", allocation = "Dynamic",subnet_id = "S1",NSG_id = "NSG1"}
  NIC2 ={name = "NIC_Backend",loc = "Japaneast",res = "Dev_Rohan",IP_name = "backend_IP", allocation = "Dynamic",subnet_id = "S2", NSG_id = "NSG2"}
 }

 VM = {
  VM1 = {name = "frontendVM",res = "Dev_Rohan",loc = "Japaneast",size = "Standard_D2s_v3",admin_username = "test123456", admin_password = "Test_123456789",
  disable_password_authentication = false, caching = "ReadWrite", storage_account_type = "Standard_LRS", publisher = "Canonical", offer = "UbuntuServer",
  sku = "16.04-LTS", version = "latest", NIC_id = "NIC1"}
  VM2 = {name = "backendVM",res = "Dev_Rohan",loc = "Japaneast",size = "Standard_D2s_v3",admin_username = "test123456", admin_password = "Test_123456789",
  disable_password_authentication = false, caching = "ReadWrite", storage_account_type = "Standard_LRS", publisher = "Canonical", offer = "UbuntuServer",
  sku = "16.04-LTS", version = "latest", NIC_id = "NIC2"}

  
 }

 lb = {
  lb1 = { name = "LoadBalancer",loc = "Japaneast", res= "Dev_Rohan", frontendIP_config = "Frontend_IP", public_ip_address_id = "pip3"}
 }

 health = {
  h1 = { name = "HealthProbe", port = 22, lb_id = "lb1"}
 }

 backendpool = {
  pool1 = {name = "Backendpool", lb_id="lb1"}
 }

 bass = {
  bass1 = { name = "NIC_Backend_Association", NIC_id = "NIC1", pool_id = "pool1"}
  bass2 = { name = "NIC_Backend_Association", NIC_id = "NIC2", pool_id = "pool1"}
 }

 rule = {
  rule1 = {name = "HTTP", proto = "Tcp", frontendIP_config = "FrontendIP", pool_id = "pool1", probe_id = "h1", lb_id = "lb1"}
 }