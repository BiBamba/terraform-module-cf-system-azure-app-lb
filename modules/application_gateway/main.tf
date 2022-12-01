
resource "azurerm_application_gateway" "appGateway" {
  name                = var.app_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

   # WAF Configuration
  sku {
    name     = var.sku_name  
    tier     = var.sku_tier  
  }

  dynamic "autoscale_configuration" {
    for_each = var.autoscale_configuration != {} ? [""] : []
    content {
      min_capacity = var.autoscale_configuration.min_capacity
      max_capacity = var.autoscale_configuration.max_capacity
    }
  }

  dynamic "waf_configuration" {
    for_each = var.waf_configuration_enabled ? [""] : []
    content {
      enabled          = var.waf_configuration.enabled
      firewall_mode    = lookup(var.waf_configuration, "firewall_mode", "Detection") 
      rule_set_type    = lookup(var.waf_configuration, "rule_set_type", "OWASP") 
      rule_set_version = lookup(var.waf_configuration, "rule_set_version", "3.2") 
    }
  }

  gateway_ip_configuration {
    name      = var.gw_ip-configuration_name
    subnet_id = var.frontend_subnet_id
  }

    # One or more frontend port configuration
  dynamic "frontend_port" {
    for_each = var.frontend_ports
    content {
      name = frontend_port.value.name
      port = lookup(frontend_port.value,"port",443)
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configuration
    content {
      name                 = frontend_ip_configuration.value.name
      public_ip_address_id = frontend_ip_configuration.value.public_ip_address_id
    }
  }

  dynamic "probe" {
    for_each = var.probes
    content {
      name = probe.value.name
      protocol = probe.value.protocol
      host = lookup(probe.value, "host", null)
      path = probe.value.path
      interval = probe.value.interval
      timeout = probe.value.timeout
      unhealthy_threshold = probe.value.unhealthy_threshold
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pools
    content {
      name = backend_address_pool.value.name
      ip_addresses = lookup(backend_address_pool.value, "ip_addresses", "") == "" ? null : split(",", backend_address_pool.value.ip_addresses)
    }
  }
  # HTTP settings
  # One or more http settings configuration
  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name                  = backend_http_settings.value.name
      cookie_based_affinity = "Disabled" // "Enabled"
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      request_timeout       = 60
      host_name             = lookup(backend_http_settings.value, "host_name", null)
      probe_name            = lookup(backend_http_settings.value, "probe_name", null)
    }
  }
  # Listeners Configuration

  # One or more http listener settings configuration
  dynamic "http_listener" {
    for_each = var.http_listeners
    content {
      name = http_listener.value.name
      frontend_ip_configuration = var.frontend_ip_configuration_name
      frondend_port_name = http_listener.value.frondend_port_name
      host_name = lookup(http_listener.value,"host_name",null)
      protocol = http_listener.value.protocol
      ssl_certificate_name = lookup(http_listener.value,"ssl_certificate_name",null)
    }
  } 

   # One or more app gateway SSL certificate configuration
  dynamic "ssl_certificate"  {
    for_each = var.ssl_certificates
    content{
            name = ssl_certificate.value.name
            data = lookup(ssl_certificate.value, "data", null)
            password = lookup(ssl_certificate.value, "password", null)
    }
  }
  # Request routing rules
  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules
    content {
      name                       = request_routing_rules.value.name
      rule_type                  = "Basic"
      http_listener_name         = request_routing_rules.value.thttp_listener_name
      backend_address_pool_name  = request_routing_rules.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rules.value.http_setting_name
    }
  } 
}

