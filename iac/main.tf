resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = "Brazil South"
}

resource "azurerm_service_plan" "main" {
  name                = var.service_plan_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "main" {
  name                                     = var.web_app_name
  location                                 = azurerm_resource_group.main.location
  resource_group_name                      = azurerm_resource_group.main.name
  service_plan_id                          = azurerm_service_plan.main.id

  site_config {
    application_stack {
      docker_registry_url = "https://index.docker.io"
      docker_image_name   = "nginx:latest"
    }
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
}