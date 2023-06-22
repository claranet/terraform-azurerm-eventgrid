data "azurecaf_name" "eventgrid_event_sub" {
  name          = var.stack
  resource_type = "azurerm_eventgrid_event_subscription"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "eventgrid-sub"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}
