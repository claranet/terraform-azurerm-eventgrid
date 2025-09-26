locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  eventgrid_name       = lower(coalesce(var.custom_name, data.azurecaf_name.eventgrid.result))
  eventgrid_topic_name = lower(coalesce(var.eventgrid_topic_custom_name, data.azurecaf_name.eventgrid_topic.result))
}
