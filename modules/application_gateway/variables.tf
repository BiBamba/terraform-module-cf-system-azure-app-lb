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

variable "frondend_subnet_name" {
  description = "This is the name of the frondend Subnet where the Application Gateway resides"
}

variable "resource_group_name" {
  description = "This is the Resource Group Name"
}

variable "virtual_network_name" {
  description = "This is the name of the virtual Network"
}

variable "frontend_public_ip" {
  description = "this is the public ip for the Application gateway"
}

variable "resource_group_location" {
  description = "This is the location(Region) of the Resource Group"
}

variable "app_gateway_name" {
  description = "This is the name of the Application Gateway"
}