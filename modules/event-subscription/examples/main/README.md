# Event Grid System Topic with Event Subscription Example

This example demonstrates how to create an Event Grid System Topic with an Event Subscription using Azure Key Vault as the source resource.

## Usage

1. Copy the example terraform.tfvars file:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars` with your specific values:
   - Update subscription ID, resource group names
   - Specify your Key Vault resource ID
   - Configure storage account details

3. Initialize and apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## What this example creates

- **Event Grid System Topic**: Configured to monitor Key Vault events
- **Event Subscription**: Routes Key Vault certificate events to a Storage Queue
- **Additional Event Subscription**: Demonstrates using the sub-module for additional subscriptions

## Key Features Demonstrated

- System Topic configuration for Key Vault events
- Storage Queue endpoint configuration
- Event filtering for specific Key Vault events
- Additional event subscription using the sub-module

## Variables

See `variables.tf` for all configurable parameters with their descriptions and default values.
