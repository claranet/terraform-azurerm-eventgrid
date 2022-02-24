output "id" {
  description = "Eventgrid subscription ID"
  value       = azurerm_eventgrid_system_topic_event_subscription.event_subscription.id
}

output "name" {
  description = "Evengrid subscription name"
  value       = azurerm_eventgrid_system_topic_event_subscription.event_subscription.name
}
