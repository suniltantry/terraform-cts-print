## Consul Print Module for Consul Terraform Sync

This Terraform module creates text files on your local machine containing Consul service information. It is a useful module to use to familiarize yourself with Consul Terraform Sync without requiring deployed infrastructure and credentials.

## Feature

The module uses the `local` Terraform provider to create local text files with information of monitored Consul services for a CTS task.

## Requirements

### Ecosystem Requirements

| Ecosystem | Version |
|-----------|---------|
| [consul](https://www.consul.io/downloads) | >= 1.7 |
| [consul-terraform-sync](https://www.consul.io/docs/nia) | >= 0.1.0 |
| [terraform](https://www.terraform.io) | >= 0.13 |

### Terraform Providers

| Name | Version |
|------|---------|
| local | >= 2.0.0 |

## Setup

There are no setup requirements for automating this module with Consul Terraform Sync. 

To view the generated files, you can navigate to the default `./sync-tasks/<task-name>` working directory of Consul Terraform Sync or the configured [`driver.terraform.working_dir`](https://www.consul.io/docs/nia/configuration#working_dir) path. There you may see new `.txt` files after running a CTS task with this module.

## Usage

**User Config for Consul Terraform Sync**

example.hcl
```hcl
task {
  name        = "example"
  source      = "findkim/print/cts"
  version     = "0.1.0"
  services    = ["web", "api"]
}
```
