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

module "keyvault" {
  source  = "claranet/keyvault/azurerm"
  version = "x.x.x"

  resource_group_name = module.rg.name
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name
  location            = module.region.location
  location_short      = module.region.location_short

  logs_destinations_ids = [
    module.logs.storage_account_id,
    module.logs.id,
  ]

  admin_objects_ids = [
    data.azurerm_client_config.current.object_id
  ]
}

resource "azurerm_storage_account" "storage_acount" {
  name                     = "examplestorageacc"
  resource_group_name      = module.rg.name
  location                 = module.region.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }
}

resource "azurerm_storage_queue" "storage_queue" {
  name                 = "mysamplequeue"
  storage_account_name = azurerm_storage_account.storage_acount.name
}
