output "eventgrid_topic_id" {
  description = "Azure Event Grid Topic ID."
  value       = var.eventgrid_type == "topic" ? azurerm_eventgrid_topic.main[0].id : null
}

output "eventgrid_topic_name" {
  description = "Azure Event Grid Topic name."
  value       = var.eventgrid_type == "topic" ? azurerm_eventgrid_topic.main[0].name : null
}

output "eventgrid_topic_resource" {
  description = "Azure Event Grid Topic resource object."
  value       = var.eventgrid_type == "topic" ? azurerm_eventgrid_topic.main[0] : null
}

output "eventgrid_topic_endpoint" {
  description = "Azure Event Grid Topic endpoint."
  value       = var.eventgrid_type == "topic" ? azurerm_eventgrid_topic.main[0].endpoint : null
}

output "eventgrid_topic_primary_access_key" {
  description = "Azure Event Grid Topic primary access key."
  value       = var.eventgrid_type == "topic" ? azurerm_eventgrid_topic.main[0].primary_access_key : null
  sensitive   = true
}

output "eventgrid_topic_secondary_access_key" {
  description = "Azure Event Grid Topic secondary access key."
  value       = var.eventgrid_type == "topic" ? azurerm_eventgrid_topic.main[0].secondary_access_key : null
  sensitive   = true
}

# Module outputs

output "module_eventgrid_event_subscription" {
  description = "Event Grid Event Subscription module output."
  value       = var.eventgrid_type == "topic" && var.enable_eventgrid_event_subscription ? module.eventgrid_event_subscription[0] : null
}

output "module_diagnostics_topic" {
  description = "Diagnostics Settings module output."
  value       = var.eventgrid_type == "topic" && length(var.logs_destinations_ids) > 0 ? module.diagnostics_topic[0] : null
}
