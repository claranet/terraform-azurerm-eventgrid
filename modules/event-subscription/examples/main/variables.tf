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

variable "source_resource_id" {
  description = "Source resource ID for Event Grid System Topic (example: Key Vault)."
  type        = string
  default     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/test/providers/Microsoft.KeyVault/vaults/test"
}

variable "storage_account_id" {
  description = "Storage account ID for queue endpoint (example)."
  type        = string
  default     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/test/providers/Microsoft.Storage/storageAccounts/test"
}

variable "queue_name" {
  description = "Storage queue name for the example."
  type        = string
  default     = "test-queue"
}
