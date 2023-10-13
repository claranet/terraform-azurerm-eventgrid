# Azure Event Grid

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/eventgrid/azurerm/)

This Terraform module creates an [Azure Eventgrid system topic](https://docs.microsoft.com/en-us/azure/event-grid/) with
an [Azure Eventgrid system topic event subscription](https://docs.microsoft.com/en-us/azure/event-grid/concepts#event-subscriptions)
and activated [Diagnostics Logs](https://docs.microsoft.com/en-us/azure/event-grid/enable-diagnostic-logs-topic).

You can create an Azure Eventgrid system topic event subscription without Eventgrid system topic by using the submodule `modules/event-subscription`.

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 7.x.x       | 1.3.x             | >= 3.0          |
| >= 6.x.x       | 1.x               | >= 3.0          |
| >= 5.x.x       | 0.15.x            | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
module "region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "logs" {
  source  = "claranet/run/azurerm//modules/logs"
  version = "x.x.x"

  resource_group_name = module.rg.resource_group_name
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name
  location            = module.region.location
  location_short      = module.region.location_short
}


data "azurerm_client_config" "current" {
}

module "keyvault" {
  source  = "claranet/keyvault/azurerm"
  version = "x.x.x"

  resource_group_name = module.rg.resource_group_name
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name
  location            = module.region.location
  location_short      = module.region.location_short

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id,
  ]

  admin_objects_ids = [
    data.azurerm_client_config.current.object_id
  ]
}


resource "azurerm_storage_account" "storage_acount" {
  name                     = "examplestorageacc"
  resource_group_name      = module.rg.resource_group_name
  location                 = module.region.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }
}

resource "azurerm_storage_queue" "storage_queue" {
  name                 = "mysamplequeue"
  storage_account_name = azurerm_storage_account.storage_acount.name
}

module "eventgrid" {
  source  = "claranet/eventgrid/azurerm"
  version = "x.x.x"

  resource_group_name = module.rg.resource_group_name
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name
  location            = module.region.location
  location_short      = module.region.location_short

  source_resource_id = module.keyvault.key_vault_id

  storage_queue_endpoint = {
    storage_account_id = azurerm_storage_account.storage_acount.id
    queue_name         = azurerm_storage_queue.storage_queue.name
  }

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2, >= 1.2.22 |
| azurerm | ~> 3.39 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | ~> 6.4.1 |
| event\_subscription | ./modules/event-subscription | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_eventgrid_system_topic.eventgrid_system_topic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_system_topic) | resource |
| [azurecaf_name.eventgrid](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| advanced\_filter | Filter a value of an event for an Event Subscription based on a condition. | <pre>object({<br>    bool_equals = optional(object({<br>      key   = string<br>      value = bool<br>    }), null)<br>    number_greater_than = optional(object({<br>      key   = string<br>      value = number<br>    }), null)<br>    number_greater_than_or_equals = optional(object({<br>      key   = string<br>      value = number<br>    }), null)<br>    number_less_than = optional(object({<br>      key   = string<br>      value = number<br>    }), null)<br>    number_less_than_or_equals = optional(object({<br>      key   = string<br>      value = number<br>    }), null)<br>    number_in = optional(object({<br>      key    = string<br>      values = list(number)<br>    }), null)<br>    number_not_in = optional(object({<br>      key    = string<br>      values = list(number)<br>    }), null)<br>    string_begins_with = optional(object({<br>      key    = string<br>      values = list(string)<br>    }), null)<br>    string_not_begins_with = optional(object({<br>      key    = string<br>      values = list(string)<br>    }), null)<br>    string_ends_with = optional(object({<br>      key    = string<br>      values = list(string)<br>    }), null)<br>    string_not_ends_with = optional(object({<br>      key    = string<br>      values = list(string)<br>    }), null)<br>    string_contains = optional(object({<br>      key    = string<br>      values = list(string)<br>    }), null)<br>    string_not_contains = optional(object({<br>      key    = string<br>      values = list(string)<br>    }), null)<br>    string_in = optional(object({<br>      key    = string<br>      values = list(string)<br>    }), null)<br>    string_not_in = optional(object({<br>      key    = string<br>      values = list(string)<br>    }), null)<br>    is_not_null = optional(object({<br>      key = string<br>    }), null)<br>    is_null_or_undefined = optional(object({<br>      key = string<br>    }), null)<br>  })</pre> | `null` | no |
| advanced\_filtering\_on\_arrays\_enabled | Specifies whether advanced filters should be evaluated against an array of values instead of expecting a singular value. | `bool` | `null` | no |
| azure\_function\_endpoint | Function where the Event Subscription will receive events. | <pre>object({<br>    function_id                       = string<br>    max_events_per_batch              = optional(number)<br>    preferred_batch_size_in_kilobytes = optional(number)<br>  })</pre> | `null` | no |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| custom\_diagnostic\_settings\_name | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| custom\_name | Custom Azure Eventgrid name, generated if not set | `string` | `""` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| delivery\_property | Option to set custom headers on delivered events. | <pre>list(object({<br>    header_name  = string<br>    type         = string<br>    value        = optional(string)<br>    source_field = optional(string)<br>    secret       = optional(bool)<br>  }))</pre> | `[]` | no |
| environment | Project environment. | `string` | n/a | yes |
| event\_delivery\_schema | Specifies the event delivery schema for the Event Subscription. Possible values include: `EventGridSchema`, `CloudEventSchemaV1_0`, `CustomInputSchema`. | `string` | `"EventGridSchema"` | no |
| event\_subscription\_custom\_name | Event subscription optional custom name | `string` | `""` | no |
| eventhub\_endpoint\_id | ID of the Event Hub where the Event subscription will receive events. | `string` | `null` | no |
| expiration\_time\_utc | Specifies the expiration time of the Event Subscription (Datetime Format RFC 3339). | `string` | `null` | no |
| extra\_tags | Additional tags to associate with your Azure Eventgrid. | `map(string)` | `{}` | no |
| hybrid\_connection\_endpoint\_id | ID of the Hybrid Connection where the Event subscription will receive events. | `string` | `null` | no |
| included\_event\_types | List of applicable event types that need to be part of the Event Subscription. | `list(string)` | `[]` | no |
| labels | List of labels to assign to the Event Subscription. | `list(string)` | `[]` | no |
| location | Azure location. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br>If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formated string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| logs\_retention\_days | Number of days to keep logs on storage account. | `number` | `30` | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| resource\_group\_name | Resource Group name. | `string` | n/a | yes |
| retry\_policy | Delivery retry attempts for events. | <pre>object({<br>    max_delivery_attempts = number<br>    event_time_to_live    = number<br>  })</pre> | `null` | no |
| service\_bus\_queue\_endpoint\_id | ID of the Service Bus Queue where the Event subscription will receive events. | `string` | `null` | no |
| service\_bus\_topic\_endpoint\_id | ID of the Service Bus Topic where the Event subscription will receive events. | `string` | `null` | no |
| source\_resource\_id | ID of the Event Grid System Topic ARM Source. | `string` | n/a | yes |
| stack | Project Stack name. | `string` | n/a | yes |
| storage\_blob\_dead\_letter\_destination | Storage blob container that is the destination of the deadletter events. | <pre>object({<br>    storage_account_id          = string<br>    storage_blob_container_name = string<br>  })</pre> | `null` | no |
| storage\_queue\_endpoint | Storage Queue endpoint block configuration where the Event subscription will receive events. | <pre>object({<br>    storage_account_id                    = string<br>    queue_name                            = string<br>    queue_message_time_to_live_in_seconds = optional(number)<br>  })</pre> | `null` | no |
| subject\_filter | Block to filter events for an Event Subscription based on a resource path prefix or suffix. | <pre>object({<br>    subject_begins_with = optional(string)<br>    subject_ends_with   = optional(string)<br>    case_sensitive      = optional(bool)<br>  })</pre> | `null` | no |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `custom_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |
| webhook\_endpoint | Webhook configuration block where the Event Subscription will receive events. | <pre>object({<br>    url                               = string<br>    base_url                          = optional(string)<br>    max_events_per_batch              = optional(number)<br>    preferred_batch_size_in_kilobytes = optional(number)<br>    active_directory_tenant_id        = optional(string)<br>    active_directory_app_id_or_uri    = optional(string)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Azure Event Grid System Topic ID |
| identity\_principal\_id | Azure Event Grid System Topic identity's principal ID |
| metric\_arm\_resource\_id | Azure Event Grid System Topic's metric ARM resource ID |
| name | Azure Event Grid System Topic name |
<!-- END_TF_DOCS -->
