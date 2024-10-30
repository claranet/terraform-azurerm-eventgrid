resource "azurerm_eventgrid_system_topic" "main" {
  name     = local.eventgrid_name
  location = var.location

  resource_group_name = var.resource_group_name

  source_arm_resource_id = var.source_resource_id
  topic_type             = local.topic_type

  identity {
    type = "SystemAssigned"
  }

  tags = merge(local.default_tags, var.extra_tags)
}

module "event_subscription" {
  source = "./modules/event-subscription"

  location_short = var.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = var.resource_group_name

  event_subscription_custom_name = var.event_subscription_custom_name

  name_prefix = var.name_prefix
  name_suffix = var.name_suffix

  eventgrid_system_topic_id = azurerm_eventgrid_system_topic.main.id

  expiration_time_utc   = var.expiration_time_utc
  event_delivery_schema = var.event_delivery_schema

  storage_queue_endpoint        = var.storage_queue_endpoint
  azure_function_endpoint       = var.azure_function_endpoint
  webhook_endpoint              = var.webhook_endpoint
  eventhub_endpoint_id          = var.eventhub_endpoint_id
  hybrid_connection_endpoint_id = var.hybrid_connection_endpoint_id
  service_bus_queue_endpoint_id = var.service_bus_queue_endpoint_id
  service_bus_topic_endpoint_id = var.service_bus_topic_endpoint_id

  included_event_types = var.included_event_types

  subject_filter  = var.subject_filter
  advanced_filter = var.advanced_filter

  delivery_property = var.delivery_property

  storage_blob_dead_letter_destination = var.storage_blob_dead_letter_destination
  retry_policy                         = var.retry_policy
  labels                               = var.labels
  advanced_filtering_on_arrays_enabled = var.advanced_filtering_on_arrays_enabled
}
