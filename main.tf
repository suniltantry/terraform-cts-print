terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">=2.0.0"
    }
  }
}

resource "local_file" "consul_service" {
  for_each = local.consul_services

  content  = join("\n", [for s in each.value : s.node_address])
  filename = "${each.key}.txt"
}

locals {
  # Create a map of service names to instance IDs to then build
  # a map of service names to instances
  consul_service_ids = transpose({
    for id, s in var.services : id => [s.name]
  })

  # Group service instances by service name
  # consul_services = {
  #   "app" = [
  #     {
  #       "id" = "app-id-01"
  #       "name" = "app"
  #       "node_address" = "192.168.10.10"
  #     }
  #   ]
  # }
  consul_services = {
    for name, ids in local.consul_service_ids :
    name => [for id in ids : var.services[id]]
  }
}
