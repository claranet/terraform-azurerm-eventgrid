variable "location" {
  description = "Azure location."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming."
  type        = string
}

variable "environment" {
  description = "Project environment."
  type        = string
}

variable "stack" {
  description = "Project Stack name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "source_resource_id" {
  description = "ID of the Event Grid System Topic ARM Source."
  type        = string
}

variable "expiration_time_utc" {
  description = "Specifies the expiration time of the Event Subscription (Datetime Format RFC 3339)."
  type        = string
  default     = null
}

variable "event_delivery_schema" {
  description = "Specifies the event delivery schema for the Event Subscription. Possible values include: `EventGridSchema`, `CloudEventSchemaV1_0`, `CustomInputSchema`."
  type        = string
  default     = "EventGridSchema"
}

variable "storage_queue_endpoint" {
  description = "Storage Queue endpoint block configuration where the Event subscription will receive events."
  type = object({
    storage_account_id                    = string
    queue_name                            = string
    queue_message_time_to_live_in_seconds = optional(number)
  })
  default = null
}

variable "azure_function_endpoint" {
  description = "Function where the Event Subscription will receive events."
  type = object({
    function_id                       = string
    max_events_per_batch              = optional(number)
    preferred_batch_size_in_kilobytes = optional(number)
  })
  default = null
}

variable "webhook_endpoint" {
  description = "Webhook configuration block where the Event Subscription will receive events."
  type = object({
    url                               = string
    base_url                          = optional(string)
    max_events_per_batch              = optional(number)
    preferred_batch_size_in_kilobytes = optional(number)
    active_directory_tenant_id        = optional(string)
    active_directory_app_id_or_uri    = optional(string)
  })
  default = null
}

variable "eventhub_endpoint_id" {
  description = "ID of the Event Hub where the Event subscription will receive events."
  type        = string
  default     = null
}

variable "hybrid_connection_endpoint_id" {
  description = "ID of the Hybrid Connection where the Event subscription will receive events."
  type        = string
  default     = null
}

variable "service_bus_queue_endpoint_id" {
  description = "ID of the Service Bus Queue where the Event subscription will receive events."
  type        = string
  default     = null
}

variable "service_bus_topic_endpoint_id" {
  description = "ID of the Service Bus Topic where the Event subscription will receive events."
  type        = string
  default     = null
}

variable "included_event_types" {
  description = "List of applicable event types that need to be part of the Event Subscription."
  type        = list(string)
  default     = []
}

variable "subject_filter" {
  description = "Block to filter events for an Event Subscription based on a resource path prefix or suffix."
  type = object({
    subject_begins_with = optional(string)
    subject_ends_with   = optional(string)
    case_sensitive      = optional(bool)
  })
  default = null
}

variable "advanced_filter" {
  description = "Filter a value of an event for an Event Subscription based on a condition."
  type = object({
    bool_equals = optional(set(object({
      key   = string
      value = bool
    })), [])
    number_greater_than = optional(set(object({
      key   = string
      value = number
    })), [])
    number_greater_than_or_equals = optional(set(object({
      key   = string
      value = number
    })), [])
    number_less_than = optional(set(object({
      key   = string
      value = number
    })), [])
    number_less_than_or_equals = optional(set(object({
      key   = string
      value = number
    })), [])
    number_in = optional(set(object({
      key    = string
      values = list(number)
    })), [])
    number_not_in = optional(set(object({
      key    = string
      values = list(number)
    })), [])
    string_begins_with = optional(set(object({
      key    = string
      values = list(string)
    })), [])
    string_not_begins_with = optional(set(object({
      key    = string
      values = list(string)
    })), [])
    string_ends_with = optional(set(object({
      key    = string
      values = list(string)
    })), [])
    string_not_ends_with = optional(set(object({
      key    = string
      values = list(string)
    })), [])
    string_contains = optional(set(object({
      key    = string
      values = list(string)
    })), [])
    string_not_contains = optional(set(object({
      key    = string
      values = list(string)
    })), [])
    string_in = optional(set(object({
      key    = string
      values = list(string)
    })), [])
    string_not_in = optional(set(object({
      key    = string
      values = list(string)
    })), [])
    is_not_null = optional(set(object({
      key = string
    })), [])
    is_null_or_undefined = optional(set(object({
      key = string
    })), [])
  })
  default = null
}

variable "delivery_property" {
  description = "Option to set custom headers on delivered events."
  type = list(object({
    header_name  = string
    type         = string
    value        = optional(string)
    source_field = optional(string)
    secret       = optional(bool)
  }))
  default = []
}

variable "storage_blob_dead_letter_destination" {
  description = "Storage blob container that is the destination of the deadletter events."
  type = object({
    storage_account_id          = string
    storage_blob_container_name = string
  })
  default = null
}

variable "retry_policy" {
  description = "Delivery retry attempts for events."
  type = object({
    max_delivery_attempts = number
    event_time_to_live    = number
  })
  default = null
}

variable "labels" {
  description = "List of labels to assign to the Event Subscription."
  type        = list(string)
  default     = []
}

variable "advanced_filtering_on_arrays_enabled" {
  description = "Specifies whether advanced filters should be evaluated against an array of values instead of expecting a singular value."
  type        = bool
  default     = null
}
