# Azure Event Grid - Topic event Subscription

This Terraform submodule creates an [Azure Eventgrid system topic event subscription](https://docs.microsoft.com/en-us/azure/event-grid/) service.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.1 |
| azurerm | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurecaf_name.eventgrid_event_sub](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurerm_eventgrid_system_topic_event_subscription.event_subscription](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic_event_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| advanced\_filter | Filter a value of an event for an event subscription based on a condition | `any` | `{}` | no |
| advanced\_filtering\_on\_arrays\_enabled | Specifies whether advanced filters should be evaluated against an array of values instead of expecting a singular value | `bool` | `false` | no |
| azure\_function\_endpoint | Function where the Event Subscription will receive events | `any` | `{}` | no |
| client\_name | Client name/account used in naming | `string` | n/a | yes |
| environment | Project environment | `string` | n/a | yes |
| event\_delivery\_schema | Specifies the event delivery schema for the event subscription. Possible values include: `EventGridSchema`, `CloudEventSchemaV1_0`, `CustomInputSchema`. | `string` | `"EventGridSchema"` | no |
| event\_subscription\_custom\_name | Event subscription optional custom name | `string` | `""` | no |
| eventgrid\_system\_topic\_id | Eventgrid system topic ID to attach the event subscription | `string` | n/a | yes |
| eventhub\_endpoint\_id | ID of the EventHub where the Event subscription will receive events | `string` | `null` | no |
| expiration\_time\_utc | Specifies the expiration time of the event subscription (Datetime Format RFC 3339). | `string` | `null` | no |
| hybrid\_connection\_endpoint\_id | ID of the Hybrid Connection where the Event subscription will receive events | `string` | `null` | no |
| included\_event\_types | List of applicable event types that need to be part of the event subscription | `list(string)` | `[]` | no |
| labels | List of labels to assign to the event subscription | `list(string)` | `null` | no |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| resource\_group\_name | Resource group name | `string` | n/a | yes |
| retry\_policy | Delivery retry attempts for events | `any` | `{}` | no |
| service\_bus\_queue\_endpoint\_id | ID of the Service Bus Queue where the Event subscription will receive events | `string` | `null` | no |
| service\_bus\_topic\_endpoint\_id | ID of the Service Bus Topic where the Event subscription will receive events | `string` | `null` | no |
| stack | Project stack name | `string` | n/a | yes |
| storage\_blob\_dead\_letter\_destination | Storage blob container that is the destination of the deadletter events | `any` | `{}` | no |
| storage\_queue\_endpoint | Storage Queue endpoint block configuration where the Event subscription will receive events | `any` | `{}` | no |
| subject\_filter | Block to filter events for an event subscription based on a resource path prefix or sufix | `any` | `{}` | no |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `custom_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Eventgrid subscription ID |
| name | Evengrid subscription name |
<!-- END_TF_DOCS -->
