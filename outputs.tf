output "id" {
  description = "Azure Event Grid System Topic ID"
  value       = azurerm_eventgrid_system_topic.eventgrid_system_topic.id
}

output "name" {
  description = "Azure Event Grid System Topic name"
  value       = azurerm_eventgrid_system_topic.eventgrid_system_topic.name
}

output "identity_principal_id" {
  description = "Azure Event Grid System Topic identity's principal ID"
  value       = azurerm_eventgrid_system_topic.eventgrid_system_topic.identity[0].principal_id
}

output "metric_arm_resource_id" {
  description = "Azure Event Grid System Topic's metric ARM resource ID"
  value       = azurerm_eventgrid_system_topic.eventgrid_system_topic.metric_arm_resource_id
}
