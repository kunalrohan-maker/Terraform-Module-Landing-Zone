RGs = {
    RG1 = {
    name = "prod_Rohan"
    loc = "Japan east"
    managed = "Rohan"
}
RG2 = {
    name = "prod_Kunal"
    loc = "Australia east"
    managed = "Kunal"
}
}

VNET = {
    V1 = {name = "Virtual_JAPAN", loc = "Japaneast", res = "prod_Rohan", add = ["10.0.0.0/16"]}
    V2 = {name = "Virtual_AUS", loc = "Australia east", res = "prod_Kunal", add = ["192.168.0.0/16"]}
}

SN = {
    S1 = {name = "frontend", res = "prod_Rohan",VNET = "Virtual_JAPAN",adf=["10.0.1.0/24"]}
    S2 = {name = "backtend", res = "prod_Rohan",VNET = "Virtual_JAPAN",adf=["10.0.2.0/24"]}
    S3 = {name = "Database", res = "prod_Rohan",VNET = "Virtual_JAPAN",adf=["10.0.3.0/24"]}
    S4 = {name = "AzureBastionSubnet", res = "prod_Rohan",VNET = "Virtual_JAPAN",adf=["10.0.4.0/28"]}
    S5 = {name = "frontend", res = "prod_Kunal",VNET = "Virtual_Aus",adf=["192.168.1.0/24"]}
    S6 = {name = "Backend", res = "prod_Kunal",VNET = "Virtual_Aus",adf=["192.168.2.0/24"]}
    S7 = {name = "Database", res = "prod_Kunal",VNET = "Virtual_Aus",adf=["192.168.3.0/24"]}
    S8 = {name = "AzureBastionSubnet", res = "prod_Kunal",VNET = "Virtual_Aus",adf=["192.168.4.0/28"]}
}