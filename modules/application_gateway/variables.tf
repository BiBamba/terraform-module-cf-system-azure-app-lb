variable "address_space" {
  default = "10.21.0.0/16"
}

variable "frontend_subnet_address_prefixes" {
  default = "10.21.0.0/24"
}

variable "backend_subnet_address_prefixes" {
  default = "10.21.1.0/24"
}

variable "websockets_frontend_port_name" {
  default = "AppGatW-Websockets-port"
}

variable "https_frontend_port_name" {
  default = "AppGatW-Https-port"
}

variable "https_frontend_port_name" {
  default = "AppGatW-Http-port"
}

variable "websockets_request_routing_rule_name" {
  default = "AppGatW_Websockets-rule"
}