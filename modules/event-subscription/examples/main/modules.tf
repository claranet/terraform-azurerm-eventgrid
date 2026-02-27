module "eventgrid" {
  source = "../../../../"

  eventgrid_type = "system_topic"

  resource_group_name = var.resource_group_name
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name
  location            = var.location
  location_short      = var.location_short

  source_resource_id = var.source_resource_id

  storage_queue_endpoint = {
    storage_account_id = var.storage_account_id
    queue_name         = var.queue_name
  }

  logs_destinations_ids = []
}

module "additional_event_subscription" {
  source = "../../"

  resource_group_name = var.resource_group_name
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name
  location_short      = var.location_short

  eventgrid_system_topic_id = module.eventgrid.id

  included_event_types = ["Microsoft.KeyVault.CertificateNewVersionCreated"]

  storage_queue_endpoint = {
    storage_account_id = var.storage_account_id
    queue_name         = var.queue_name
  }
}
