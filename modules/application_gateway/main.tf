# Frontend Subnet
resource "azurerm_subnet" "prod-cf-edge-0" {
  name                 = "prod-cf-edge-0"
  resource_group_name  = azurerm_resource_group.Production.name
  virtual_network_name = azurerm_virtual_network.Production.name
  address_prefixes     = var.frontend_subnet_address_prefixes
}

# Backend pool Subnet
resource "azurerm_subnet" "prod-cf-core-0" {
  name                 = "prod-cf-core-0"
  resource_group_name  = azurerm_resource_group.Production.name
  virtual_network_name = azurerm_virtual_network.Production.name
  address_prefixes     = var.backend_subnet_address_prefixes
}

# Frontend IP address
resource "azurerm_public_ip" "prod-ip" {
  name                = "cf-prod"
  resource_group_name = azurerm_resource_group.Production.name
  location            = var.resource_location
  allocation_method   = "Static"
  sku                 = "Standard"
}

output "azure_public_ips_prod_cf" {
  value = "azurerm_public_ip.prod-ip.ip_address"
}

#-----------------------------------------------------------------
# Generating SSL certificates
#-----------------------------------------------------------------

# To convert the PEM certificate in PFX we need a password
resource "random_password" "pfx-password" {
  #count = 2
  length = 24
  special = true
}

# This resource converts the PEM certicate in PFX
resource "pkcs12_from_pem" "certificate" {
  cert_pem = var.dba_cert_pem
  private_key_pem = var.dba_private_key_pem
  password = random_password.pfx-password.result
  #password = random_password.pfx-password[0].result
}

/*
resource "pkcs12_from_pem" "dbe_certificate" {
  cert_pem = var.dbe_cert_pem
  private_key_pem = var.dbe_private_key_pem
  password = random_password.pfx-password.result
  #password = random_password.pfx-password[1].result
}
*/

#--------------------------------------------------------------------------------------------------------------
# Application Gateway
#--------------------------------------------------------------------------------------------------------------- 
resource "azurerm_application_gateway" "prod-lb" {
  name                = "db-cf-prod-public-lb"
  resource_group_name = azurerm_resource_group.Production.name
  location            = var.resource_location

  # WAF Configuration
  sku {
    name     = var.sku_name  //Make a choice: "WAF_Medium", "WAF_Large", "WAF_v2"
    tier     = var.sku_tier  //Make a choice: "WAF", "WAF_v2"
    capacity = var.sku_capacity // What capacity do they want
  }

  autoscale_configuration {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Detection" // Make a choice: "Detection" or "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"
  }

  gateway_ip_configuration {
    name      = "db-cf-prod-public-lb-ip-configuration"
    subnet_id = azurerm_subnet.prod-cf-edge-0.id
  }

  frontend_port {
    name = var.frontend_port_name
    port = 80
  }

  frontend_port {
    name = var.https_frontend_port_name
    port = 443
  }

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.prod-ip.id
  }

  backend_address_pool {
    name = var.backend_address_pool_name
  }

# HTTP settings
  backend_http_settings {
    name                  = var.https_setting_name
    cookie_based_affinity = "Disabled" // "Enabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 15
  }

  backend_http_settings {
    name                  = var.http_setting_name
    cookie_based_affinity = "Disabled" // "Enabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 15
  }

# Listeners Configuration
  http_listener {
    name                           = var.https_listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.https_frontend_port_name
    protocol                       = "Https"
    ssl_certificate_name           = var.ssl_certificate_name // we will need a ssl certificate
  }
 
  http_listener {
    name                           = var.listener_name
    frontend_ip_configuration_name = var.frontend_ip_configuration_name
    frontend_port_name             = var.frontend_port_name
    protocol                       = "Http"
  }


# SSL Certificates
  ssl_certificate {
    name = var.ssl_certificate_name
    data = pkcs12_from_pem.certificate.result
    password = pkcs12_from_pem.certificate.password
  }

# Request routing rules

  request_routing_rule {
    name                       = var.https_request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = var.https_listener_name
    backend_address_pool_name  = var.backend_address_pool_name
    backend_http_settings_name = var.https_setting_name
  }
  
  redirect_configuration {
    name                 = var.redirect_configuration_name
    redirect_type        = "Permanent"
    include_path         = true
    include_query_string = true
    target_listener_name = var.https_listener_name
  }

  request_routing_rule {
    name                       = var.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = var.listener_name
    redirect_configuration_name = var.redirect_configuration_name
  }
}
# Health probes Configuration
#  probe {
#    interval = "15"
#    name = var.prob_http_name
#    protocol = "Http"
#    path = ""
#    timout = 15
#    unhealthy_threshold = 5
#  }
#
#  probe {
#    interval = "15"
#    name = var.prob_https_name
#    protocol = "Https"
#    path = ""
#    timout = 15
#    unhealthy_threshold = 5
#  }
