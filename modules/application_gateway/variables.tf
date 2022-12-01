variable "resource_group_name" {
  description = "This is the Resource Group Name"
}

variable "virtual_network_name" {
  description = "This is the name of the virtual Network"
}

variable "resource_group_location" {
  description = "This is the location(Region) of the Resource Group"
}

variable "frontend_subnet_name" {
  description = "This is the name of the frondend Subnet where the Application Gateway resides"
}

variable "address_space" {}

variable "frontend_subnet_address_prefixes" {}

variable "backend_subnet_address_prefixes" {}


variable "app_gateway_name" {
  description = "This is the name of the Application Gateway"
}

variable "sku_name " {
  description = "The SKU name of WAF configuration"
}

variable "sku_tier" {
  description = "The tier name of WAF configuration"
}

variable "sku_capacity" {
  description = "The capacity of WAF configuration"
}

variable "autoscale_configuration" {
  description = ""
  default = {}
  type = map(string)
  # autoscale_configuration = { min_capacity = "", max_capacity = "" }
}

variable "waf_configuration" {
  description = ""
  default = {}
  type = map(string)
  # waf_configuration = { enabled = "", firewall_mode = "", rule_set_type = "", rule_set_version = ""}
}

variable "gw_ip-configuration_name" {
  description = "This is the name of the gateway ip configuration"
}

variable "frontend_subnet_id" {
  description = "This is the id of the Frontend Subnet"
}

variable "frontend_ports" {
  type = map(object({
    name = string
    port = number
  }))
}

variable "frontend_ip_configuration" {
  type = object({
    name = string
    public_ip_address_id = string
  })
}

variable "probes" {
  type = list(object({
    name = string
    protocol = string
    host = string
    path = string
    interval = number
    timeout = number
    unhealthy_threshold = number
  }))
}

variable "backend_address_pools" {
  type = list(object({
    name          = string
    ip_addresses  = string
  }))
}

variable "backend_http_settings" {
  type = list(object({
    name                  = string
    port                  = string
    protocol              = string
    request_timeout       = number
    host_name             = string
    probe_name             = string

  }))
}

variable "http_listeners" {
  type = list(object({
    name = string 
    frontend_ip_configuration_name = string
    frontend_port_name = string
    host_name = string
    protocol = string
    ssl_certificate_name = string

  }))
}

variable "ssl_certificates" {
  type = list(object({
    name = string
    data = string
    password = string
  }))
}

variable "request_routing_rules" {
  type = list(object({
    name                       = string
    http_listener_name         = string
    backend_address_pool_name  = string
    backend_http_settings_name = string
  }))
}