output "id" {
  description = "Azure Event Grid System Topic ID."
  value       = azurerm_eventgrid_system_topic.main.id
}

output "name" {
  description = "Azure Event Grid System Topic name."
  value       = azurerm_eventgrid_system_topic.main.name
}

output "identity_principal_id" {
  description = "Azure Event Grid System Topic identity's principal ID."
  value       = azurerm_eventgrid_system_topic.main.identity[0].principal_id
}

output "metric_arm_resource_id" {
  description = "Azure Event Grid System Topic's metric ARM resource ID."
  value       = azurerm_eventgrid_system_topic.main.metric_arm_resource_id
}

output "resource" {
  description = "Azure Event Grid System Topic resource object."
  value       = azurerm_eventgrid_system_topic.main
}

output "module_event_subscription" {
  description = "Event Subscription module output."
  value       = module.event_subscription
}
