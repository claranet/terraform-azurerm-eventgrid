variable "resource_group_id" {
  description = "ID of the Resource Group where the Event Subscription will be created."
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

variable "azure_function_endpoint" {
  description = "Function where the Event Subscription will receive events."
  type = object({
    function_id                       = string
    max_events_per_batch              = optional(number)
    preferred_batch_size_in_kilobytes = optional(number)
  })
  default = null
}

variable "eventhub_endpoint_id" {
  description = "Event Hub where the Event Subscription will receive events."
  type        = string
  default     = null
}

variable "hybrid_connection_endpoint_id" {
  description = "Hybrid Connection where the Event Subscription will receive events."
  type        = string
  default     = null
}

variable "service_bus_queue_endpoint_id" {
  description = "Service Bus Queue where the Event Subscription will receive events."
  type        = string
  default     = null
}

variable "service_bus_topic_endpoint_id" {
  description = "Service Bus Topic where the Event Subscription will receive events."
  type        = string
  default     = null
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

variable "included_event_types" {
  description = "A list of event types that should be included in the Event Subscription."
  type        = list(string)
  default     = null
}

variable "subject_filter" {
  description = "Subject filter block to filter events for the Event Subscription."
  type = object({
    subject_begins_with = optional(string)
    subject_ends_with   = optional(string)
    case_sensitive      = optional(bool)
  })
  default = null
}

variable "advanced_filter" {
  description = "Advanced filter block to filter events for the Event Subscription. More than one block can be specified."
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
    number_in_range = optional(set(object({
      key    = string
      values = list(number)
    })), [])
    number_not_in_range = optional(set(object({
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

variable "delivery_identity" {
  description = "Delivery identity block for the Event Subscription."
  type = object({
    type                   = string
    user_assigned_identity = optional(string)
  })
  default = null
}

variable "delivery_property" {
  description = "Delivery property block for the Event Subscription."
  type = object({
    header_name  = string
    type         = string
    value        = optional(string)
    source_field = optional(string)
    secret       = optional(string)
  })
  default = null
}

variable "dead_letter_identity" {
  description = "Dead letter identity block for the Event Subscription."
  type = object({
    type                   = string
    user_assigned_identity = optional(string)
  })
  default = null
}

variable "storage_blob_dead_letter_destination" {
  description = "Storage Blob dead letter destination block for the Event Subscription."
  type = object({
    storage_account_id          = string
    storage_blob_container_name = string
  })
  default = null
}

variable "retry_policy" {
  description = "Retry policy block for the Event Subscription."
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
  description = "A boolean flag which enables advanced filtering on arrays."
  type        = bool
  default     = false
}
