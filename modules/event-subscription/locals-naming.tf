locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  event_subscription_name = lower(coalesce(var.event_subscription_custom_name, data.azurecaf_name.eventgrid_event_sub.result))
}
