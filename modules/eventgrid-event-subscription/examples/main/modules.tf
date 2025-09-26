# Main Event Grid Topic with Event Grid Event Subscription
module "eventgrid" {
  source = "../../../../"

  # Choose Event Grid Topic type
  eventgrid_type = "topic"

  resource_group_name = var.resource_group_name
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name
  location            = var.location
  location_short      = var.location_short

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

  logs_destinations_ids = []
}

# Additional standalone Event Grid Event Subscription
module "additional_eventgrid_event_subscription" {
  source = "../../"

  stack          = var.stack
  environment    = var.environment
  client_name    = var.client_name
  location_short = var.location_short

  # Scope can be a resource group, topic, or other resource
  resource_group_id = var.resource_group_id

  # Azure Function endpoint example
  azure_function_endpoint = {
    function_id                       = var.function_id
    max_events_per_batch              = 10
    preferred_batch_size_in_kilobytes = 64
  }

  included_event_types = [
    "Microsoft.Resources.ResourceWriteSuccess",
    "Microsoft.Resources.ResourceDeleteSuccess"
  ]

  subject_filter = {
    subject_begins_with = var.resource_group_id
    case_sensitive      = true
  }

  # Dead letter configuration
  storage_blob_dead_letter_destination = {
    storage_account_id          = var.storage_account_id
    storage_blob_container_name = var.dead_letter_container_name
  }

  dead_letter_identity = {
    type = "SystemAssigned"
  }

  custom_name = "additional-subscription"
}
