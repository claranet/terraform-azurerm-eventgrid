# EventGrid Event Subscription

This Terraform module creates an Event Grid Event Subscription in Azure with comprehensive configuration capabilities.

## Features

- Creation of an Event Grid Event Subscription
- Support for multiple endpoint types (Azure Functions, Webhooks, Storage Queue, Service Bus, etc.)
- Advanced filters for events
- Configuration of retry and dead letter policies
- Support for managed identities for delivery

## Usage

```hcl
module "eventgrid_event_subscription" {
  source = "./modules/eventgrid-event-subscription"

  location_short = "we"
  client_name    = "mycompany"
  environment    = "prod"
  stack          = "myapp"

  resource_group_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-rg"

  azure_function_endpoint = {
    function_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-rg/providers/Microsoft.Web/sites/my-function/functions/my-trigger"
  }

  included_event_types = [
    "Microsoft.Storage.BlobCreated",
    "Microsoft.Storage.BlobDeleted"
  ]

  subject_filter = {
    subject_begins_with = "/blobServices/default/containers/images/"
    subject_ends_with   = ".jpg"
    case_sensitive      = false
  }
}
```

## Variables

### Required Variables

| Name | Type | Description |
|------|------|-------------|
| `location_short` | `string` | Short code for Azure region |
| `client_name` | `string` | Client name used in naming |
| `environment` | `string` | Project environment |
| `stack` | `string` | Project stack name |
| `resource_group_id` | `string` | Resource Group ID or scope for the Event Subscription |

### Optional Variables

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `custom_name` | `string` | `""` | Custom name for the Event Subscription |
| `expiration_time_utc` | `string` | `null` | Expiration date in RFC 3339 format |
| `event_delivery_schema` | `string` | `"EventGridSchema"` | Event delivery schema |
| `azure_function_endpoint` | `object` | `null` | Azure Function endpoint configuration |
| `webhook_endpoint` | `object` | `null` | Webhook endpoint configuration |
| `storage_queue_endpoint` | `object` | `null` | Storage Queue endpoint configuration |
| `included_event_types` | `list(string)` | `null` | Event types to include |
| `subject_filter` | `object` | `null` | Subject filter |
| `advanced_filter` | `object` | `null` | Advanced filters |
| `delivery_identity` | `object` | `null` | Identity for delivery |
| `retry_policy` | `object` | `null` | Retry policy |
| `labels` | `list(string)` | `[]` | Labels to assign |

## Outputs

| Name | Description |
|------|-------------|
| `id` | Event Grid Event Subscription ID |

## Supported Endpoints

- **Azure Function**: Delivery to an Azure Function
- **Webhook**: Delivery to an HTTP/HTTPS endpoint
- **Storage Queue**: Delivery to an Azure Storage Queue
- **Service Bus Queue**: Delivery to a Service Bus Queue
- **Service Bus Topic**: Delivery to a Service Bus Topic
- **Event Hub**: Delivery to an Event Hub
- **Hybrid Connection**: Delivery to a Hybrid Connection

## Filters

### Subject Filter

Allows filtering events based on the subject:

```hcl
subject_filter = {
  subject_begins_with = "/blobServices/default/containers/images/"
  subject_ends_with   = ".jpg"
  case_sensitive      = false
}
```

### Advanced Filter

Allows complex filters on event properties:

```hcl
advanced_filter = {
  string_contains = [{
    key    = "data.api"
    values = ["PutBlob", "CopyBlob"]
  }]
  number_greater_than = [{
    key   = "data.contentLength"
    value = 1024
  }]
}
```

## Examples

See the `examples/` folder for complete usage examples.

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

More details are available in the [CONTRIBUTING.md](../../CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
# Main Event Grid Topic with Event Grid Event Subscription
module "eventgrid" {
  source  = "claranet/eventgrid/azurerm"
  version = "x.x.x"

  # Choose Event Grid Topic type
  eventgrid_type = "topic"

  resource_group_name = module.rg.name
  stack               = var.stack
  environment         = var.environment
  client_name         = var.client_name
  location            = module.region.location
  location_short      = module.region.location_short

  # source_resource_id not needed for topic type
  source_resource_id = null

  # Event Grid Topic configuration
  identity_type                 = "SystemAssigned"
  input_schema                  = "EventGridSchema"
  public_network_access_enabled = true
  local_auth_enabled            = true

  # Event Subscription configuration
  webhook_endpoint = {
    url = "https://example.com/webhook"
  }

  included_event_types = [
    "MyApp.OrderCreated",
    "MyApp.OrderProcessed",
    "MyApp.PaymentReceived"
  ]

  subject_filter = {
    subject_begins_with = "/orders/"
    subject_ends_with   = "/completed"
    case_sensitive      = false
  }

  advanced_filter = {
    string_contains = [
      {
        key = "data.orderType"
        values = [
          "premium",
          "enterprise"
        ]
      }
    ]
    number_greater_than = [
      {
        key   = "data.orderValue"
        value = 100
      }
    ]
  }

  # Delivery configuration
  eventgrid_delivery_identity = {
    type = "SystemAssigned"
  }

  retry_policy = {
    max_delivery_attempts = 3
    event_time_to_live    = 1440 # 24 hours in minutes
  }

  labels                               = ["production", "orders"]
  advanced_filtering_on_arrays_enabled = true

  logs_destinations_ids = [
    module.logs.storage_account_id,
    module.logs.id,
  ]
}

# Additional standalone Event Grid Event Subscription
module "additional_eventgrid_event_subscription" {
  source  = "claranet/eventgrid/azurerm//modules/eventgrid-event-subscription"
  version = "x.x.x"

  stack          = var.stack
  environment    = var.environment
  client_name    = var.client_name
  location_short = module.region.location_short

  # Scope can be a resource group, topic, or other resource
  resource_group_id = module.rg.id

  # Azure Function endpoint example
  azure_function_endpoint = {
    function_id                       = azurerm_linux_function_app.example.id
    max_events_per_batch              = 10
    preferred_batch_size_in_kilobytes = 64
  }

  included_event_types = [
    "Microsoft.Resources.ResourceWriteSuccess",
    "Microsoft.Resources.ResourceDeleteSuccess"
  ]

  subject_filter = {
    subject_begins_with = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${module.rg.name}"
    case_sensitive      = true
  }

  # Dead letter configuration
  storage_blob_dead_letter_destination = {
    storage_account_id          = azurerm_storage_account.deadletter.id
    storage_blob_container_name = azurerm_storage_container.deadletter.name
  }

  dead_letter_identity = {
    type = "SystemAssigned"
  }

  custom_name = "additional-subscription"
}
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | >= 1.2.28 |
| azurerm | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_eventgrid_event_subscription.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_event_subscription) | resource |
| [azurecaf_name.eventgrid_event_subscription](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| advanced\_filter | Advanced filter block to filter events for the Event Subscription. More than one block can be specified. | <pre>object({<br/>    bool_equals = optional(set(object({<br/>      key   = string<br/>      value = bool<br/>    })), [])<br/>    number_greater_than = optional(set(object({<br/>      key   = string<br/>      value = number<br/>    })), [])<br/>    number_greater_than_or_equals = optional(set(object({<br/>      key   = string<br/>      value = number<br/>    })), [])<br/>    number_less_than = optional(set(object({<br/>      key   = string<br/>      value = number<br/>    })), [])<br/>    number_less_than_or_equals = optional(set(object({<br/>      key   = string<br/>      value = number<br/>    })), [])<br/>    number_in = optional(set(object({<br/>      key    = string<br/>      values = list(number)<br/>    })), [])<br/>    number_not_in = optional(set(object({<br/>      key    = string<br/>      values = list(number)<br/>    })), [])<br/>    number_in_range = optional(set(object({<br/>      key    = string<br/>      values = list(number)<br/>    })), [])<br/>    number_not_in_range = optional(set(object({<br/>      key    = string<br/>      values = list(number)<br/>    })), [])<br/>    string_begins_with = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    string_not_begins_with = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    string_ends_with = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    string_not_ends_with = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    string_contains = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    string_not_contains = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    string_in = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    string_not_in = optional(set(object({<br/>      key    = string<br/>      values = list(string)<br/>    })), [])<br/>    is_not_null = optional(set(object({<br/>      key = string<br/>    })), [])<br/>    is_null_or_undefined = optional(set(object({<br/>      key = string<br/>    })), [])<br/>  })</pre> | `null` | no |
| advanced\_filtering\_on\_arrays\_enabled | A boolean flag which enables advanced filtering on arrays. | `bool` | `false` | no |
| azure\_function\_endpoint | Function where the Event Subscription will receive events. | <pre>object({<br/>    function_id                       = string<br/>    max_events_per_batch              = optional(number)<br/>    preferred_batch_size_in_kilobytes = optional(number)<br/>  })</pre> | `null` | no |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| custom\_name | Event Grid Event Subscription optional custom name. | `string` | `""` | no |
| dead\_letter\_identity | Dead letter identity block for the Event Subscription. | <pre>object({<br/>    type                   = string<br/>    user_assigned_identity = optional(string)<br/>  })</pre> | `null` | no |
| delivery\_identity | Delivery identity block for the Event Subscription. | <pre>object({<br/>    type                   = string<br/>    user_assigned_identity = optional(string)<br/>  })</pre> | `null` | no |
| delivery\_property | Delivery property block for the Event Subscription. | <pre>object({<br/>    header_name  = string<br/>    type         = string<br/>    value        = optional(string)<br/>    source_field = optional(string)<br/>    secret       = optional(string)<br/>  })</pre> | `null` | no |
| environment | Project environment. | `string` | n/a | yes |
| event\_delivery\_schema | Specifies the event delivery schema for the Event Subscription. Possible values include: `EventGridSchema`, `CloudEventSchemaV1_0`, `CustomInputSchema`. | `string` | `"EventGridSchema"` | no |
| eventhub\_endpoint\_id | Event Hub where the Event Subscription will receive events. | `string` | `null` | no |
| expiration\_time\_utc | Specifies the expiration time of the Event Subscription (Datetime Format RFC 3339). | `string` | `null` | no |
| hybrid\_connection\_endpoint\_id | Hybrid Connection where the Event Subscription will receive events. | `string` | `null` | no |
| included\_event\_types | A list of event types that should be included in the Event Subscription. | `list(string)` | `null` | no |
| labels | List of labels to assign to the Event Subscription. | `list(string)` | `[]` | no |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| resource\_group\_id | ID of the Resource Group where the Event Subscription will be created. | `string` | n/a | yes |
| retry\_policy | Retry policy block for the Event Subscription. | <pre>object({<br/>    max_delivery_attempts = number<br/>    event_time_to_live    = number<br/>  })</pre> | `null` | no |
| service\_bus\_queue\_endpoint\_id | Service Bus Queue where the Event Subscription will receive events. | `string` | `null` | no |
| service\_bus\_topic\_endpoint\_id | Service Bus Topic where the Event Subscription will receive events. | `string` | `null` | no |
| stack | Project Stack name. | `string` | n/a | yes |
| storage\_blob\_dead\_letter\_destination | Storage Blob dead letter destination block for the Event Subscription. | <pre>object({<br/>    storage_account_id          = string<br/>    storage_blob_container_name = string<br/>  })</pre> | `null` | no |
| storage\_queue\_endpoint | Storage Queue endpoint block configuration where the Event subscription will receive events. | <pre>object({<br/>    storage_account_id                    = string<br/>    queue_name                            = string<br/>    queue_message_time_to_live_in_seconds = optional(number)<br/>  })</pre> | `null` | no |
| subject\_filter | Subject filter block to filter events for the Event Subscription. | <pre>object({<br/>    subject_begins_with = optional(string)<br/>    subject_ends_with   = optional(string)<br/>    case_sensitive      = optional(bool)<br/>  })</pre> | `null` | no |
| webhook\_endpoint | Webhook configuration block where the Event Subscription will receive events. | <pre>object({<br/>    url                               = string<br/>    base_url                          = optional(string)<br/>    max_events_per_batch              = optional(number)<br/>    preferred_batch_size_in_kilobytes = optional(number)<br/>    active_directory_tenant_id        = optional(string)<br/>    active_directory_app_id_or_uri    = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Event Grid Event subscription ID. |
<!-- END_TF_DOCS -->
