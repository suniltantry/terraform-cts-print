#
# var.services is a required input variable for Consul Terraform Sync
#
# An example of the services input value:
# services = {
#   "app-id-01.worker-01.dc1" : {
#     id              = "app-id-01"
#     name            = "app"
#     ...
#   },
#   "web.worker-01.dc1" : {
#     ...
#   }
# }
#
variable "services" {
  description = "Consul services monitored by Consul-Terraform-Sync"
  type = map(
    object({
      id        = string
      name      = string
      kind      = string
      address   = string
      port      = number
      meta      = map(string)
      tags      = list(string)
      namespace = string
      status    = string

      node                  = string
      node_id               = string
      node_address          = string
      node_datacenter       = string
      node_tagged_addresses = map(string)
      node_meta             = map(string)

      cts_user_defined_meta = map(string)
    })
  )
}

variable "include_meta" {
  description = "Include service metadata in the generated files"
  type        = bool
  default     = false
}

variable "consul_kv" {
  description = "Consul KV pair"
  type        = map(string)
}
