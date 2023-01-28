provider "azurerm" {
  features {}
}
variable "kv-name" {
  description = "Set name of keyvault"
  default = "INSERT-KEYVAULT-NAME"
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg-web-app-configs" {
  name     = "rg-web-app"
  location = "Central US"
}


resource "azurerm_key_vault" "keyvault" {
  name                        = var.kv-name
  location                    = azurerm_resource_group.rg-web-app-configs.location
  resource_group_name         = azurerm_resource_group.rg-web-app-configs.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get", "Delete", "Set", "List"
    ]

  }

    access_policy {
    tenant_id = azurerm_linux_web_app.web-app.identity[0].tenant_id
    object_id = azurerm_linux_web_app.web-app.identity[0].principal_id

    secret_permissions = [
      "Get", "List"
    ]
  }
}

resource "azurerm_service_plan" "free-linux" {
  name                = "asp-web-app-plan"
  resource_group_name = azurerm_resource_group.rg-web-app-configs.name
  location            = azurerm_resource_group.rg-web-app-configs.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "web-app" {
  name                = "asfgadhgg"
  resource_group_name = azurerm_resource_group.rg-web-app-configs.name
  location            = azurerm_service_plan.free-linux.location
  service_plan_id     = azurerm_service_plan.free-linux.id

  site_config {
    container_registry_use_managed_identity = false

    application_stack {
      docker_image     = "dlau/asdfgag"
      docker_image_tag = "latest"
    }
  }

  app_settings = {
    DOCKER_REGISTRY_SERVER_URL = "https://index.docker.io/v1"
    "CONFIG_VALUE_SAMPLE_KV"   = "@Microsoft.KeyVault(SecretUri=https://${var.kv-name}.vault.azure.net/secrets/ADD-SECRET-HERE/)"
  }

  identity {
    type = "SystemAssigned"
  }

}

