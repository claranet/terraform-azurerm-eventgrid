# Variables spécifiques à azurerm_eventgrid_topic

variable "identity_type" {
  description = "The type of Managed Identity used for the Event Grid Topic. Possible values include: `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`, `None`."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "The list of User Assigned Managed Identity IDs used for the Event Grid Topic."
  type        = list(string)
  default     = []
}

variable "input_schema" {
  description = "The input schema for the Event Grid Topic."
  type        = string
  default     = "EventGridSchema"
}

variable "input_mapping_fields" {
  description = "Input mapping fields for the Event Grid Topic."
  type = list(object({
    id           = optional(string)
    topic        = optional(string)
    event_type   = optional(string)
    event_time   = optional(string)
    data_version = optional(string)
    subject      = optional(string)
  }))
  default  = []
  nullable = false
}

variable "input_mapping_default_values" {
  description = "Input mapping default values for the Event Grid Topic."
  type = list(object({
    event_type   = optional(string)
    data_version = optional(string)
    subject      = optional(string)
  }))
  default  = []
  nullable = false
}

variable "public_network_access_enabled" {
  description = "Specifies whether public network access is enabled for the Event Grid Topic."
  type        = bool
  default     = true
}

variable "local_auth_enabled" {
  description = "Specifies whether local authentication is enabled for the Event Grid Topic."
  type        = bool
  default     = true
}

variable "inbound_ip_rule" {
  description = "Inbound IP rules for the Event Grid Topic."
  type = list(object({
    ip_mask = string
    action  = optional(string)
  }))
  default = []
}

# Variables pour Event Grid Event Subscription pour topic

variable "eventgrid_event_subscription_custom_name" {
  description = "Event Grid Event Subscription optional custom name."
  type        = string
  default     = ""
}

variable "eventgrid_topic_scope" {
  description = "The scope for the Event Grid Event Subscription. Can be resource group ID or topic ID."
  type        = string
  default     = null
}

variable "eventgrid_delivery_identity" {
  description = "Delivery identity block for the Event Grid Event Subscription."
  type = object({
    type                   = string
    user_assigned_identity = optional(string)
  })
  default = {
    type = "SystemAssigned"
  }
}

variable "eventgrid_dead_letter_identity" {
  description = "Dead letter identity block for the Event Grid Event Subscription."
  type = object({
    type                   = string
    user_assigned_identity = optional(string)
  })
  default = null
}
