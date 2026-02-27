resource "azurerm_eventgrid_topic" "main" {
  count = var.eventgrid_type == "topic" ? 1 : 0

  name                = local.eventgrid_topic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  input_schema = var.input_schema

  dynamic "input_mapping_fields" {
    for_each = var.input_mapping_fields
    content {
      id           = input_mapping_fields.value.id
      topic        = input_mapping_fields.value.topic
      event_type   = input_mapping_fields.value.event_type
      event_time   = input_mapping_fields.value.event_time
      data_version = input_mapping_fields.value.data_version
      subject      = input_mapping_fields.value.subject
    }
  }

  dynamic "input_mapping_default_values" {
    for_each = var.input_mapping_default_values
    content {
      event_type   = input_mapping_default_values.value.event_type
      data_version = input_mapping_default_values.value.data_version
      subject      = input_mapping_default_values.value.subject
    }

  }

  public_network_access_enabled = var.public_network_access_enabled
  local_auth_enabled            = var.local_auth_enabled

  dynamic "inbound_ip_rule" {
    for_each = var.inbound_ip_rule
    content {
      action  = inbound_ip_rule.value.action
      ip_mask = inbound_ip_rule.value.ip_mask
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}

module "eventgrid_event_subscription" {
  count  = var.eventgrid_type == "topic" && var.enable_eventgrid_event_subscription ? 1 : 0
  source = "./modules/eventgrid-event-subscription"

  location_short = var.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  custom_name = var.eventgrid_event_subscription_custom_name

  name_prefix = var.name_prefix
  name_suffix = var.name_suffix

  resource_group_id = coalesce(var.eventgrid_topic_scope, azurerm_eventgrid_topic.main[0].id)

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

  delivery_identity    = var.eventgrid_delivery_identity
  delivery_property    = one(var.delivery_property)
  dead_letter_identity = var.eventgrid_dead_letter_identity

  storage_blob_dead_letter_destination = var.storage_blob_dead_letter_destination
  retry_policy                         = var.retry_policy
  labels                               = var.labels
  advanced_filtering_on_arrays_enabled = var.advanced_filtering_on_arrays_enabled
}
