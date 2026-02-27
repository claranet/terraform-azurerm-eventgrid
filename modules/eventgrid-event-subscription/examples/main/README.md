# Event Grid Topic with Event Grid Event Subscription Example

This example demonstrates how to create a custom Event Grid Topic with Event Grid Event Subscriptions for custom application events.

## Usage

1. Copy the example terraform.tfvars file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your specific values:
   - Update subscription ID, resource group names
   - Specify your Azure Function resource ID
   - Configure storage account details for dead letter

3. Initialize and apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## What this example creates

- **Event Grid Topic**: Custom topic for application events
- **Event Subscription**: Routes custom events to a webhook endpoint
- **Additional Event Grid Event Subscription**: Routes resource group events to an Azure Function

## Key Features Demonstrated

- Custom Event Grid Topic configuration
- Webhook endpoint configuration
- Azure Function endpoint configuration
- Advanced filtering and retry policies
- Dead letter destination configuration
- Custom event types and subject filtering

## Variables

See `variables.tf` for all configurable parameters with their descriptions and default values.
