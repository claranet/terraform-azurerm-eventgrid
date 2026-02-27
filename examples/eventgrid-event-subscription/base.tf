module "region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location       = module.region.location
  location_short = module.region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack
}

module "logs" {
  source  = "claranet/run/azurerm//modules/logs"
  version = "x.x.x"

  resource_group_name = module.rg.name
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name
  location            = module.region.location
  location_short      = module.region.location_short
}

data "azurerm_client_config" "current" {
}

# Example Function App for Azure Function endpoint
resource "azurerm_service_plan" "example" {
  name                = "example-serviceplan"
  resource_group_name = module.rg.name
  location            = module.region.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_storage_account" "function_storage" {
  name                     = "examplefuncstorageacc"
  resource_group_name      = module.rg.name
  location                 = module.region.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_linux_function_app" "example" {
  name                = "example-function-app"
  resource_group_name = module.rg.name
  location            = module.region.location

  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key
  service_plan_id            = azurerm_service_plan.example.id

  https_only = true

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet"
  }
}

# Dead letter storage account and container
resource "azurerm_storage_account" "deadletter" {
  name                     = "exampledeadletterstorage"
  resource_group_name      = module.rg.name
  location                 = module.region.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  blob_properties {
    versioning_enabled = true
  }

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_container" "deadletter" {
  name                  = "deadletter"
  storage_account_id    = azurerm_storage_account.deadletter.id
  container_access_type = "private"

  lifecycle {
    prevent_destroy = true
  }
}
