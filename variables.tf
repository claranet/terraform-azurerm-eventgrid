variable "location" {
  description = "Azure location."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "source_resource_id" {
  description = "ID of the Event Grid System Topic ARM Source."
  type        = string
}

variable "expiration_time_utc" {
  description = "Specifies the expiration time of the event subscription (Datetime Format RFC 3339)."
  type        = string
  default     = null
}

variable "event_delivery_schema" {
  description = "Specifies the event delivery schema for the event subscription. Possible values include: `EventGridSchema`, `CloudEventSchemaV1_0`, `CustomInputSchema`."
  type        = string
  default     = "EventGridSchema"
}

variable "azure_function_endpoint" {
  description = "Function where the Event Subscription will receive events"
  type        = any
  default     = null
}

variable "eventhub_endpoint_id" {
  description = "ID of the EventHub where the Event subscription will receive events"
  type        = string
  default     = null
}

variable "hybrid_connection_endpoint_id" {
  description = "ID of the Hybrid Connection where the Event subscription will receive events"
  type        = string
  default     = null
}

variable "service_bus_queue_endpoint_id" {
  description = "ID of the Service Bus Queue where the Event subscription will receive events"
  type        = string
  default     = null
}

variable "service_bus_topic_endpoint_id" {
  description = "ID of the Service Bus Topic where the Event subscription will receive events"
  type        = string
  default     = null
}

variable "storage_queue_endpoint" {
  description = "Storage Queue endpoint block configuration where the Event subscription will receive events"
  type        = any
  default     = null
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
  description = "List of applicable event types that need to be part of the event subscription"
  type        = list(string)
  default     = []
}

variable "subject_filter" {
  description = "Block to filter events for an event subscription based on a resource path prefix or sufix"
  type        = any
  default     = null
}

variable "advanced_filter" {
  description = "Filter a value of an event for an event subscription based on a condition"
  type        = any
  default     = null
}

variable "storage_blob_dead_letter_destination" {
  description = "Storage blob container that is the destination of the deadletter events"
  type        = any
  default     = {}
}

variable "retry_policy" {
  description = "Delivery retry attempts for events"
  type        = any
  default     = {}
}

variable "labels" {
  description = "List of labels to assign to the event subscription"
  type        = list(string)
  default     = null
}

variable "advanced_filtering_on_arrays_enabled" {
  description = "Specifies whether advanced filters should be evaluated against an array of values instead of expecting a singular value"
  type        = bool
  default     = false
}
