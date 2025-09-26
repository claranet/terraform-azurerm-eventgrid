variable "location" {
  description = "Azure location."
  type        = string
  default     = "France Central"
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
  default     = "frc"
}

variable "client_name" {
  description = "Client name/account used in naming."
  type        = string
  default     = "test"
}

variable "environment" {
  description = "Project environment."
  type        = string
  default     = "test"
}

variable "stack" {
  description = "Project Stack name."
  type        = string
  default     = "ci"
}

variable "resource_group_name" {
  description = "Resource group name for the example."
  type        = string
  default     = "rg-test"
}

variable "resource_group_id" {
  description = "Resource group ID for event subscription scope."
  type        = string
  default     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/test"
}

variable "function_id" {
  description = "Azure Function ID for webhook endpoint."
  type        = string
  default     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/test/providers/Microsoft.Web/sites/test-function"
}

variable "storage_account_id" {
  description = "Storage account ID for dead letter destination."
  type        = string
  default     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/test/providers/Microsoft.Storage/storageAccounts/test"
}

variable "dead_letter_container_name" {
  description = "Container name for dead letter destination."
  type        = string
  default     = "deadletter"
}
