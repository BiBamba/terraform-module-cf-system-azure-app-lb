variable "resource_group_name" {
  description = "This is the Resource Group Name"
}

variable "virtual_network_name" {
  description = "This is the name of the virtual Network"
}

variable "resource_group_location" {
  description = "This is the location(Region) of the Resource Group"
}

variable "frondend_subnet_name" {
  description = "This is the name of the frondend Subnet where the Application Gateway resides"
}

variable "frondend_subnet_id" {
  description = "This is the id of the Frontend Subnet"
}

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

variable "frontend_public_ip_name" {
  description = "this is the name of the public ip for the Application gateway"
}

variable "frontend_public_ip_id" {
  description = "This is teh id of the public ip of the Application Gateway"
}

variable "app_gateway_name" {
  description = "This is the name of the Application Gateway"
}

variable "gw_ip-configuration_name" {
  description = "This is the name of the gateway ip configuration"
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

variable "min_capacity" {
  description= "The minimum capacity in the autoscaling configuration"
}

variable "max_capacity" {
  description= "The maximum capacity in the autoscaling configuration"
}

variable "probe_name" {
  description = "The http probe name"
}

variable "https_probe_name" {
  description = "The https probe name"
}

variable "backend_address_pool_name" {
  description = "The name of the backend address pool"
}

variable "https_setting_name" {
  description = "The name of the http setting for https " 
}

variable "http_setting_name" {
  description = "The name of the http setting for http " 
}

variable "https_listener_name" {
  description = "The name of the http listeners for https protocol"
}

variable "ssl_certificate_name" {
  description = "The name of the ssl certificate of the https listeners"
}

variable "listener_name" {
  description = "The name of the http listeners for http protocol"
}

variable "https_request_routing_rule_name" {
  description = "The name of the https request rule"
}

variable "websockets_request_routing_rule_name" {
  default = "AppGatW_Websockets-rule"
}

variable "redirect_configuration_name" {
  description = "The name of redirect configuration for http to https "
}

variable "http_request_routing_rule_name" {
  description = "The name of the http request rule"
}