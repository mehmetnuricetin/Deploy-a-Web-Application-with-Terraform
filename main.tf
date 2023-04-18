terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "= 2.99"
    }
  }
}

provider "azurerm" {
  features {}

  skip_provider_registration = true
  version = "=2.99.0"
}

resource "azurerm_resource_group" "rg" {
  name     = "<YOUR_RESOURCE_GROUP_NAME>"
  location = "eastus"
}

resource "azurerm_app_service_plan" "svcplan" {
  name                = "newweb-appserviceplan"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "appsvc" {
  name                = "custom-tf-webapp-for-thestudent-[add some unique characters]"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.svcplan.id
}
