output "id" {
  description = "Eventgrid subscription ID."
  value       = azurerm_eventgrid_system_topic_event_subscription.main.id
}

output "name" {
  description = "Evengrid subscription name."
  value       = azurerm_eventgrid_system_topic_event_subscription.main.name
}

output "resource" {
  description = "Eventgrid subscription resource object."
  value       = azurerm_eventgrid_system_topic_event_subscription.main
}
