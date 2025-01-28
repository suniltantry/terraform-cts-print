terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">=2.0.0"
    }
  }
}

# Create a file per Consul service with addresses written in each file
resource "local_file" "consul_service" {
  for_each = local.service_details
  content = join("\n", [
    for s in each.value ]
  ])
  filename = "${each.key}.txt"
}

output "consul_services" {
  value = local.consul_services
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
