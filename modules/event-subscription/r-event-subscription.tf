resource "azurerm_eventgrid_system_topic_event_subscription" "event_subscription" {
  name                = local.event_subscription_name
  system_topic        = element(split("/", var.eventgrid_system_topic_id), 8)
  resource_group_name = var.resource_group_name

  expiration_time_utc   = var.expiration_time_utc
  event_delivery_schema = var.event_delivery_schema

  dynamic "azure_function_endpoint" {
    for_each = var.azure_function_endpoint != null ? ["azure_function_endpoint"] : []
    content {
      function_id                       = lookup(var.azure_function_endpoint, "function_id", "")
      max_events_per_batch              = lookup(var.azure_function_endpoint, "max_events_per_batch", null)
      preferred_batch_size_in_kilobytes = lookup(var.azure_function_endpoint, "preferred_batch_size_in_kilobytes", null)
    }
  }

  dynamic "storage_queue_endpoint" {
    for_each = var.storage_queue_endpoint != null ? ["storage_queue_endpoint"] : []
    content {
      storage_account_id                    = lookup(var.storage_queue_endpoint, "storage_account_id", "")
      queue_name                            = lookup(var.storage_queue_endpoint, "queue_name", null)
      queue_message_time_to_live_in_seconds = lookup(var.storage_queue_endpoint, "queue_message_time_to_live_in_seconds", null)
    }
  }

  dynamic "webhook_endpoint" {
    for_each = var.webhook_endpoint[*]
    content {
      url                               = webhook_endpoint.value.url
      base_url                          = webhook_endpoint.value.base_url
      max_events_per_batch              = webhook_endpoint.value.max_events_per_batch
      preferred_batch_size_in_kilobytes = webhook_endpoint.value.preferred_batch_size_in_kilobytes
      active_directory_tenant_id        = webhook_endpoint.value.active_directory_tenant_id
      active_directory_app_id_or_uri    = webhook_endpoint.value.active_directory_app_id_or_uri
    }
  }

  eventhub_endpoint_id          = try(var.eventhub_endpoint_id, "")
  hybrid_connection_endpoint_id = try(var.hybrid_connection_endpoint_id, "")
  service_bus_queue_endpoint_id = try(var.service_bus_queue_endpoint_id, "")
  service_bus_topic_endpoint_id = try(var.service_bus_topic_endpoint_id, "")

  included_event_types = var.included_event_types

  dynamic "subject_filter" {
    for_each = var.subject_filter != null ? ["subject_filter"] : []
    content {
      subject_begins_with = lookup(var.subject_filter, "subject_begins_with", null)
      subject_ends_with   = lookup(var.subject_filter, "subject_ends_with", null)
      case_sensitive      = lookup(var.subject_filter, "case_sensitive", null)
    }
  }

  dynamic "advanced_filter" {
    for_each = var.advanced_filter != null ? ["advanced_filter"] : []
    content {
      dynamic "bool_equals" {
        for_each = lookup(var.advanced_filter, "bool_equals", {}) != {} ? ["bool_equals"] : []
        content {
          key   = lookup(var.advanced_filter, "bool_equals.key", null)
          value = lookup(var.advanced_filter, "bool_equals.value", null)
        }
      }
      dynamic "number_greater_than" {
        for_each = lookup(var.advanced_filter, "number_greater_than", {}) != {} ? ["number_greater_than"] : []
        content {
          key   = lookup(var.advanced_filter, "number_greater_than.key", null)
          value = lookup(var.advanced_filter, "number_greater_than.value", null)
        }
      }
      dynamic "number_greater_than_or_equals" {
        for_each = lookup(var.advanced_filter, "number_greater_than_or_equals", {}) != {} ? ["number_greater_than_or_equals"] : []
        content {
          key   = lookup(var.advanced_filter, "number_greater_than_or_equals.key", null)
          value = lookup(var.advanced_filter, "number_greater_than_or_equals.value", null)
        }
      }
      dynamic "number_less_than" {
        for_each = lookup(var.advanced_filter, "number_less_than", {}) != {} ? ["number_less_than"] : []
        content {
          key   = lookup(var.advanced_filter, "number_less_than.key", null)
          value = lookup(var.advanced_filter, "number_less_than.value", null)
        }
      }
      dynamic "number_less_than_or_equals" {
        for_each = lookup(var.advanced_filter, "number_less_than_or_equals", {}) != {} ? ["number_less_than_or_equals"] : []
        content {
          key   = lookup(var.advanced_filter, "number_less_than_or_equals.key", null)
          value = lookup(var.advanced_filter, "number_less_than_or_equals.value", null)
        }
      }
      dynamic "number_in" {
        for_each = lookup(var.advanced_filter, "number_in", {}) != {} ? ["number_in"] : []
        content {
          key    = lookup(var.advanced_filter, "number_in.key", null)
          values = lookup(var.advanced_filter, "number_in.values", null)
        }
      }
      dynamic "number_not_in" {
        for_each = lookup(var.advanced_filter, "number_not_in", {}) != {} ? ["number_not_in"] : []
        content {
          key    = lookup(var.advanced_filter, "number_not_in.key", null)
          values = lookup(var.advanced_filter, "number_not_in.values", null)
        }
      }
      dynamic "string_begins_with" {
        for_each = lookup(var.advanced_filter, "string_begins_with", {}) != {} ? ["string_begins_with"] : []
        content {
          key    = lookup(var.advanced_filter, "string_begins_with.key", null)
          values = lookup(var.advanced_filter, "string_begins_with.values", null)
        }
      }
      dynamic "string_not_begins_with" {
        for_each = lookup(var.advanced_filter, "string_not_begins_with", {}) != {} ? ["string_not_begins_with"] : []
        content {
          key    = lookup(var.advanced_filter, "string_not_begins_with.key", null)
          values = lookup(var.advanced_filter, "string_not_begins_with.values", null)
        }
      }
      dynamic "string_ends_with" {
        for_each = lookup(var.advanced_filter, "string_ends_with", {}) != {} ? ["string_ends_with"] : []
        content {
          key    = lookup(var.advanced_filter, "string_ends_with.key", null)
          values = lookup(var.advanced_filter, "string_ends_with.values", null)
        }
      }
      dynamic "string_not_ends_with" {
        for_each = lookup(var.advanced_filter, "string_not_ends_with", {}) != {} ? ["string_not_ends_with"] : []
        content {
          key    = lookup(var.advanced_filter, "string_not_ends_with.key", null)
          values = lookup(var.advanced_filter, "string_not_ends_with.values", null)
        }
      }
      dynamic "string_contains" {
        for_each = lookup(var.advanced_filter, "string_contains", {}) != {} ? ["string_contains"] : []
        content {
          key    = lookup(var.advanced_filter, "string_contains.key", null)
          values = lookup(var.advanced_filter, "string_contains.values", null)
        }
      }
      dynamic "string_not_contains" {
        for_each = lookup(var.advanced_filter, "string_not_contains", {}) != {} ? ["string_not_contains"] : []
        content {
          key    = lookup(var.advanced_filter, "string_not_contains.key", null)
          values = lookup(var.advanced_filter, "string_not_contains.values", null)
        }
      }
      dynamic "string_in" {
        for_each = lookup(var.advanced_filter, "string_in", {}) != {} ? ["string_in"] : []
        content {
          key    = lookup(var.advanced_filter, "string_in.key", null)
          values = lookup(var.advanced_filter, "string_in.values", null)
        }
      }
      dynamic "string_not_in" {
        for_each = lookup(var.advanced_filter, "string_not_in", {}) != {} ? ["string_not_in"] : []
        content {
          key    = lookup(var.advanced_filter, "string_not_in.key", null)
          values = lookup(var.advanced_filter, "string_not_in.values", null)
        }
      }
      dynamic "is_not_null" {
        for_each = lookup(var.advanced_filter, "is_not_null", {}) != {} ? ["is_not_null"] : []
        content {
          key = lookup(var.advanced_filter, "is_not_null.key", null)
        }
      }
      dynamic "is_null_or_undefined" {
        for_each = lookup(var.advanced_filter, "is_null_or_undefined", {}) != {} ? ["is_null_or_undefined"] : []
        content {
          key = lookup(var.advanced_filter, "is_null_or_undefined.key", null)
        }
      }
    }
  }

  dynamic "storage_blob_dead_letter_destination" {
    for_each = var.storage_blob_dead_letter_destination
    content {
      storage_account_id          = lookup(var.storage_blob_dead_letter_destination, "storage_account_id", null)
      storage_blob_container_name = lookup(var.storage_blob_dead_letter_destination, "storage_blob_container_name", null)
    }
  }

  dynamic "retry_policy" {
    for_each = var.retry_policy
    content {
      max_delivery_attempts = lookup(var.retry_policy, "max_delivery_attempts", null)
      event_time_to_live    = lookup(var.retry_policy, "event_time_to_live", null)
    }
  }

  labels                               = var.labels
  advanced_filtering_on_arrays_enabled = var.advanced_filtering_on_arrays_enabled
}
