provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-web-app-configs" {
  name     = "rg-web-app"
  location = "Central US"
}

resource "azurerm_service_plan" "free-linux" {
  name                = "asp-web-app-plan"
  resource_group_name = azurerm_resource_group.rg-web-app-configs.name
  location            = azurerm_resource_group.rg-web-app-configs.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "example" {
  name                = "ase-app-config-test"
  resource_group_name = azurerm_resource_group.rg-web-app-configs.name
  location            = azurerm_service_plan.free-linux.location
  service_plan_id     = azurerm_service_plan.free-linux.id

  site_config {
    container_registry_use_managed_identity = false

    application_stack {
      docker_image     = "dlaue/azure-container-web-app"
      docker_image_tag = "latest"
    }
  }

  app_settings                      = {
    DOCKER_REGISTRY_SERVER_URL = "https://index.docker.io/v1"
  }

  identity {
    type = "SystemAssigned"
  }

}