output "id" {
  description = "Azure Event Grid System Topic ID."
  value       = var.eventgrid_type == "system_topic" ? azurerm_eventgrid_system_topic.main[0].id : null
}

output "name" {
  description = "Azure Event Grid System Topic name."
  value       = var.eventgrid_type == "system_topic" ? azurerm_eventgrid_system_topic.main[0].name : null
}

output "identity_principal_id" {
  description = "Azure Event Grid System Topic identity's principal ID."
  value       = var.eventgrid_type == "system_topic" ? azurerm_eventgrid_system_topic.main[0].identity[0].principal_id : null
}

output "metric_arm_resource_id" {
  description = "Azure Event Grid System Topic's metric ARM resource ID."
  value       = var.eventgrid_type == "system_topic" ? azurerm_eventgrid_system_topic.main[0].metric_arm_resource_id : null
}

output "resource" {
  description = "Azure Event Grid System Topic resource object."
  value       = var.eventgrid_type == "system_topic" ? azurerm_eventgrid_system_topic.main[0] : null
}

# Module outputs
output "module_event_subscription" {
  description = "Event Subscription module output."
  value       = var.eventgrid_type == "system_topic" && var.enable_eventgrid_event_subscription ? module.event_subscription[0] : null
}

output "module_diagnostics_system_topic" {
  description = "Diagnostics Settings module output."
  value       = var.eventgrid_type == "system_topic" && length(var.logs_destinations_ids) > 0 ? module.diagnostics_system_topic[0] : null
}
