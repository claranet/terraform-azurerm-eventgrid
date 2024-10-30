# Generic naming variables
variable "name_prefix" {
  description = "Optional prefix for the generated name."
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name."
  type        = string
  default     = ""
}

# Custom naming override
variable "custom_name" {
  description = "Custom Azure Eventgrid name, generated if not set."
  type        = string
  default     = ""
}

variable "event_subscription_custom_name" {
  description = "Event subscription optional custom name."
  type        = string
  default     = ""
}
