terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">=2.0.0"
    }
  }
}

# Create a file per Consul service with addresses written in each file
resource "local_file" "all_service_details" {
  content = join("\n\n", [
    for service in local.service_details : <<EOT
Name: ${service.name}
ID: ${service.id}
Port: ${service.port}
Address: ${service.address}
Tags: ${join(", ", service.tags)}
EOT
  ])

  filename = "${random_string.random_file_name.result}.txt"
}

# Generate a random file name
resource "random_string" "random_file_name" {
  length  = 8
  special = false
  upper   = false
}


locals {
  # Group service instances by service name
  consul_services = {
    for id, s in var.services : s.name => s...
  }
  service_details = [
    for _, service in var.services : {
      name    = service.name
      id      = service.id
      port    = service.port
      address = service.address
      tags    = service.tags
    }
  ]
}
