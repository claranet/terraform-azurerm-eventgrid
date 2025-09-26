module "diagnostics_system_topic" {
  count = var.eventgrid_type == "system_topic" && length(var.logs_destinations_ids) > 0 ? 1 : 0

  source  = "claranet/diagnostic-settings/azurerm"
  version = "~> 8.2.0"

  resource_id = azurerm_eventgrid_system_topic.main[0].id

  logs_destinations_ids = var.logs_destinations_ids
  log_categories        = var.logs_categories
  metric_categories     = var.logs_metrics_categories

  custom_name = var.diagnostic_settings_custom_name
  name_prefix = var.name_prefix
  name_suffix = var.name_suffix
}

module "diagnostics_topic" {
  count = var.eventgrid_type == "topic" && length(var.logs_destinations_ids) > 0 ? 1 : 0

  source  = "claranet/diagnostic-settings/azurerm"
  version = "~> 8.2.0"

  resource_id = azurerm_eventgrid_topic.main[0].id

  logs_destinations_ids = var.logs_destinations_ids
  log_categories        = var.logs_categories
  metric_categories     = var.logs_metrics_categories

  custom_name = var.diagnostic_settings_custom_name
  name_prefix = var.name_prefix
  name_suffix = var.name_suffix
}
