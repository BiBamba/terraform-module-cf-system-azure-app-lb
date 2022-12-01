output "agw_id" {
  description = "This is the ID of the Azure application Gateway"
  value = azurerm_application_gateway.appGateway.id
}

output "agw_name" {
  description = "this is the name of the azure application Gateway"
  value = azurerm_application_gateway.appGateway.name
}

output "agw_resource_group_name" {
  value = azurerm_application_gateway.appGateway.resource_group_name
}

output "agw_location" {
  value = azurerm_application_gateway.appGateway.location
}

output "backend_address_pools" {
  value = azurerm_application_gateway.appGateway.backend_address_pool
}

output "ssl_certificates" {
  value = azurerm_application_gateway.appGateway.ssl_certificate
}

output "http_listeners" {
  value = azurerm_application_gateway.appGateway.http_listener
}

output "backend_http_settings" {
  value = azurerm_application_gateway.appGateway.backend_http_settings
}

output "request_routing_rules" {
  value = azurerm_application_gateway.appGateway.request_routung_rule
}
