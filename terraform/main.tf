# Mengonfigurasi Provider Azure
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Membuat Resource Group 
resource "azurerm_resource_group" "rg_network" {
  name     = "rg-sipmas-network"
  location = "Southeast Asia"
}

# Membuat Virtual Network (VNet) Utama
resource "azurerm_virtual_network" "vnet_sipmas" {
  name                = "vnet-sipmas"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_network.location
  resource_group_name = azurerm_resource_group.rg_network.name
}

# Membuat Subnet 1: Khusus untuk Web App 
resource "azurerm_subnet" "subnet_web" {
  name                 = "subnet-web-app"
  resource_group_name  = azurerm_resource_group.rg_network.name
  virtual_network_name = azurerm_virtual_network.vnet_sipmas.name
  address_prefixes     = ["10.0.1.0/24"]
  
  # Delegasi khusus agar Azure Web App bisa masuk
  delegation {
    name = "delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# Membuat Subnet 2: Khusus untuk Database 
resource "azurerm_subnet" "subnet_db" {
  name                 = "subnet-database"
  resource_group_name  = azurerm_resource_group.rg_network.name
  virtual_network_name = azurerm_virtual_network.vnet_sipmas.name
  address_prefixes     = ["10.0.2.0/24"]
  
  # Service Endpoint untuk mengamankan koneksi dari Web App ke Database
  service_endpoints    = ["Microsoft.Sql"]
}