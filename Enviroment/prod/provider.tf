terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.80.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "Rohan_RES"
    storage_account_name = "storagerohan"
    container_name = "prod"
    key = "prod.statefile"
    
  }
}

provider "azurerm" {
    features {
    }
  
}