# Azure Event Grid

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/eventgrid/azurerm/)

This Terraform module creates an [Azure Event Grid system topic](https://docs.microsoft.com/en-us/azure/event-grid/) with
an [Azure Event Grid system topic event subscription](https://docs.microsoft.com/en-us/azure/event-grid/concepts#event-subscriptions)
and activated [Diagnostics Logs](https://docs.microsoft.com/en-us/azure/event-grid/enable-diagnostic-logs-topic).

You can create an Azure Event Grid system topic event subscription without Event Grid system topic by using the submodule `modules/event-subscription`.

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
module "eventgrid" {
  source  = "claranet/eventgrid/azurerm"
  version = "x.x.x"

  resource_group_name = module.rg.name
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name
  location            = module.region.location
  location_short      = module.region.location_short

  source_resource_id = module.keyvault.id
  storage_queue_endpoint = {
    storage_account_id = azurerm_storage_account.storage_acount.id
    queue_name         = azurerm_storage_queue.storage_queue.name
  }

  logs_destinations_ids = [
    module.logs.storage_account_id,
    module.logs.id,
  ]
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2.28 |
| azurerm | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | ~> 8.0.0 |
| event\_subscription | ./modules/event-subscription | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_eventgrid_system_topic.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic) | resource |
| [azurecaf_name.eventgrid](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| advanced\_filter | Filter a value of an event for an Event Subscription based on a condition. | <pre>object({<br/>    bool_equals = optional(set(object({<br/>      key   = string<br/>      value = bool<br/>    })), [])<br/>    number_greater_than = optional(set(object({<br/>      key   = string<br/>      value = number<br/>    })), [])<br/>    number_greater_than_or_equals = optional(set(object({<br/>      key   = string<br/>      value = number<br/>    })), [])<br/>    number_less_than = optional(set(object({<br/>      key   = string<br/>      value = number<br/>    })), [])<br/>    number_less_than_or_equals = optional(set(object({<br/>      key   = string<br/>      value = number<br/>    })), [])<br/>    number_in = optional(set(object({<br/>      key    = string<br/>      values = list(number)<br/>    })), [])<br/>    number_not_in = optional(set(object({<br/>      key    = string<br/>      values = list(number)<br/>    })), [])<br/>    string_begins_with = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    string_not_begins_with = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    string_ends_with = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    string_not_ends_with = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    string_contains = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    string_not_contains = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    string_in = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    string_not_in = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    is_not_null = optional(set(object({<br/>      key = string<br/>    })), [])<br/>    is_null_or_undefined = optional(set(object({<br/>      key = string<br/>    })), [])<br/>  })</pre> | `null` | no |
| advanced\_filtering\_on\_arrays\_enabled | Specifies whether advanced filters should be evaluated against an array of values instead of expecting a singular value. | `bool` | `null` | no |
| azure\_function\_endpoint | Function where the Event Subscription will receive events. | <pre>object({<br/>    function_id                       = string<br/>    max_events_per_batch              = optional(number)<br/>    preferred_batch_size_in_kilobytes = optional(number)<br/>  })</pre> | `null` | no |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| custom\_name | Custom Azure Event Grid name, generated if not set. | `string` | `""` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| delivery\_property | Option to set custom headers on delivered events. | <pre>list(object({<br/>    header_name  = string<br/>    type         = string<br/>    value        = optional(string)<br/>    source_field = optional(string)<br/>    secret       = optional(bool)<br/>  }))</pre> | `[]` | no |
| diagnostic\_settings\_custom\_name | Custom name of the diagnostics settings, name will be `default` if not set. | `string` | `"default"` | no |
| environment | Project environment. | `string` | n/a | yes |
| event\_delivery\_schema | Specifies the event delivery schema for the Event Subscription. Possible values include: `EventGridSchema`, `CloudEventSchemaV1_0`, `CustomInputSchema`. | `string` | `"EventGridSchema"` | no |
| event\_subscription\_custom\_name | Event subscription optional custom name. | `string` | `""` | no |
| eventhub\_endpoint\_id | ID of the Event Hub where the Event subscription will receive events. | `string` | `null` | no |
| expiration\_time\_utc | Specifies the expiration time of the Event Subscription (Datetime Format RFC 3339). | `string` | `null` | no |
| extra\_tags | Additional tags to associate with your Azure Eventgrid. | `map(string)` | `{}` | no |
| hybrid\_connection\_endpoint\_id | ID of the Hybrid Connection where the Event subscription will receive events. | `string` | `null` | no |
| included\_event\_types | List of applicable event types that need to be part of the Event Subscription. | `list(string)` | `[]` | no |
| labels | List of labels to assign to the Event Subscription. | `list(string)` | `[]` | no |
| location | Azure location. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br/>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br/>If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| resource\_group\_name | Resource Group name. | `string` | n/a | yes |
| retry\_policy | Delivery retry attempts for events. | <pre>object({<br/>    max_delivery_attempts = number<br/>    event_time_to_live    = number<br/>  })</pre> | `null` | no |
| service\_bus\_queue\_endpoint\_id | ID of the Service Bus Queue where the Event subscription will receive events. | `string` | `null` | no |
| service\_bus\_topic\_endpoint\_id | ID of the Service Bus Topic where the Event subscription will receive events. | `string` | `null` | no |
| source\_resource\_id | ID of the Event Grid System Topic ARM Source. | `string` | n/a | yes |
| stack | Project Stack name. | `string` | n/a | yes |
| storage\_blob\_dead\_letter\_destination | Storage blob container that is the destination of the deadletter events. | <pre>object({<br/>    storage_account_id          = string<br/>    storage_blob_container_name = string<br/>  })</pre> | `null` | no |
| storage\_queue\_endpoint | Storage Queue endpoint block configuration where the Event subscription will receive events. | <pre>object({<br/>    storage_account_id                    = string<br/>    queue_name                            = string<br/>    queue_message_time_to_live_in_seconds = optional(number)<br/>  })</pre> | `null` | no |
| subject\_filter | Block to filter events for an Event Subscription based on a resource path prefix or suffix. | <pre>object({<br/>    subject_begins_with = optional(string)<br/>    subject_ends_with   = optional(string)<br/>    case_sensitive      = optional(bool)<br/>  })</pre> | `null` | no |
| webhook\_endpoint | Webhook configuration block where the Event Subscription will receive events. | <pre>object({<br/>    url                               = string<br/>    base_url                          = optional(string)<br/>    max_events_per_batch              = optional(number)<br/>    preferred_batch_size_in_kilobytes = optional(number)<br/>    active_directory_tenant_id        = optional(string)<br/>    active_directory_app_id_or_uri    = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Azure Event Grid System Topic ID. |
| identity\_principal\_id | Azure Event Grid System Topic identity's principal ID. |
| metric\_arm\_resource\_id | Azure Event Grid System Topic's metric ARM resource ID. |
| module\_diagnostics | Diagnostics Settings module output. |
| module\_event\_subscription | Event Subscription module output. |
| name | Azure Event Grid System Topic name. |
| resource | Azure Event Grid System Topic resource object. |
<!-- END_TF_DOCS -->
