output "id" {
  description = "Event Grid subscription ID."
  value       = azurerm_eventgrid_system_topic_event_subscription.main.id
}

output "name" {
  description = "Event Grid subscription name."
  value       = azurerm_eventgrid_system_topic_event_subscription.main.name
}

output "resource" {
  description = "Event Grid subscription resource object."
  value       = azurerm_eventgrid_system_topic_event_subscription.main
}
