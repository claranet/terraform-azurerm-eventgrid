
module "eventgrid" {
  source  = "claranet/eventgrid/azurerm"
  version = "x.x.x"

  resource_group_name = module.rg.name
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name
  location            = module.region.location
  location_short      = module.region.location_short

  source_resource_id = module.keyvault.id

  storage_queue_endpoint = {
    storage_account_id = azurerm_storage_account.storage_acount.id
    queue_name         = azurerm_storage_queue.storage_queue.name
  }

  logs_destinations_ids = [
    # module.logs.logs_storage_account_id,
    # module.logs.log_analytics_workspace_id
  ]
}
