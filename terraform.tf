terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.49.0"
    }
  }
}

provider "azurerm" {
  features {}
}

// Create resource group
resource "azurerm_resource_group" "gruvedrift" {
  name     = "gruvedriftresourcegroup"
  location = "West Europe"
}

// Create ACR - Azure Container Registry
resource "azurerm_container_registry" "gruvedrift" {
  name                          = "gruvedriftcontainerregistry"
  resource_group_name           = azurerm_resource_group.gruvedrift.name
  location                      = azurerm_resource_group.gruvedrift.location
  sku                           = "Basic"
  admin_enabled                 = true
  public_network_access_enabled = true
}

// Create ACI - Azure Container Instance
resource "azurerm_container_group" "gruvedrift" {
  name                = "gruvedriftcontainergroup"
  location            = azurerm_resource_group.gruvedrift.location
  resource_group_name = azurerm_resource_group.gruvedrift.name
  dns_name_label      = "thedoorajar"
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = "Always"


  // Provide credentials from ACR creation
  image_registry_credential {
    username = azurerm_container_registry.gruvedrift.name
    password = azurerm_container_registry.gruvedrift.admin_password
    server   = azurerm_container_registry.gruvedrift.login_server
  }

  container {
    name   = "gruvedriftcontainer"
    image  = "${azurerm_container_registry.gruvedrift.login_server}/coop-de-grace:latest"
    cpu    = 1
    memory = 2

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
