# Main Event Grid Topic with Event Grid Event Subscription
module "eventgrid" {
  source  = "claranet/eventgrid/azurerm"
  version = "x.x.x"

  # Choose Event Grid Topic type
  eventgrid_type = "topic"

  resource_group_name = module.rg.name
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name
  location            = module.region.location
  location_short      = module.region.location_short

  # source_resource_id not needed for topic type
  source_resource_id = null

  # Event Grid Topic configuration
  identity_type                 = "SystemAssigned"
  input_schema                  = "EventGridSchema"
  public_network_access_enabled = true
  local_auth_enabled            = true

  # Event Subscription configuration
  webhook_endpoint = {
    url = "https://example.com/webhook"
  }

  included_event_types = [
    "MyApp.OrderCreated",
    "MyApp.OrderProcessed",
    "MyApp.PaymentReceived"
  ]

  subject_filter = {
    subject_begins_with = "/orders/"
    subject_ends_with   = "/completed"
    case_sensitive      = false
  }

  advanced_filter = {
    string_contains = [
      {
        key = "data.orderType"
        values = [
          "premium",
          "enterprise"
        ]
      }
    ]
    number_greater_than = [
      {
        key   = "data.orderValue"
        value = 100
      }
    ]
  }

  # Delivery configuration
  eventgrid_delivery_identity = {
    type = "SystemAssigned"
  }

  retry_policy = {
    max_delivery_attempts = 3
    event_time_to_live    = 1440 # 24 hours in minutes
  }

  labels                               = ["production", "orders"]
  advanced_filtering_on_arrays_enabled = true

  logs_destinations_ids = [
    module.logs.storage_account_id,
    module.logs.id,
  ]
}

# Additional standalone Event Grid Event Subscription
module "additional_eventgrid_event_subscription" {
  source  = "claranet/eventgrid/azurerm//modules/eventgrid-event-subscription"
  version = "x.x.x"

  stack          = var.stack
  environment    = var.environment
  client_name    = var.client_name
  location_short = module.region.location_short

  # Scope can be a resource group, topic, or other resource
  resource_group_id = module.rg.id

  # Azure Function endpoint example
  azure_function_endpoint = {
    function_id                       = azurerm_linux_function_app.example.id
    max_events_per_batch              = 10
    preferred_batch_size_in_kilobytes = 64
  }

  included_event_types = [
    "Microsoft.Resources.ResourceWriteSuccess",
    "Microsoft.Resources.ResourceDeleteSuccess"
  ]

  subject_filter = {
    subject_begins_with = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${module.rg.name}"
    case_sensitive      = true
  }

  # Dead letter configuration
  storage_blob_dead_letter_destination = {
    storage_account_id          = azurerm_storage_account.deadletter.id
    storage_blob_container_name = azurerm_storage_container.deadletter.name
  }

  dead_letter_identity = {
    type = "SystemAssigned"
  }

  custom_name = "additional-subscription"
}
