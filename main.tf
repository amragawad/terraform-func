resource "azurerm_resource_group" "example" {
  name     = var.name
  location =  var.location
}

resource "azurerm_storage_account" "example" {
  name                     = var.saname
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "example" {
  name                = "azure-functions-test-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "example" {
  name                       = var.funcname
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  app_service_plan_id        = azurerm_app_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  version = "~4"

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "node"
    "WEBSITE_NODE_DEFAULT_VERSION" = "~14"
    "CLOSE_PERC" = var.CLOSE_PERC
    "CRYPT" = "ETH"
    "CURRENCY" = "EUR"
    "DEC_NUM" = 4
    "DEC_NUM_FIAT" = 2
    "EXCHANGE" = "Binance"
    "MIN_VOLUME" = 0.0001
    "NOTIF_LINK" = var.NOTIF_LINK
    "PAIR" = "ETHEUR"
    "PERC_ARRAY" = var.PERC_ARRAY
    "SLEEP_TIME" = 1000
  }
}