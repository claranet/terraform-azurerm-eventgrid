# Variables spécifiques à azurerm_eventgrid_system_topic

variable "source_resource_id" {
  description = "ID of the Event Grid System Topic ARM Source. Required when eventgrid_type is 'system_topic'."
  type        = string
  default     = null
}
