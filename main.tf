##########################################################################################################################
# DEPLOY AZURE APPLICATION GATEWAY WITH WAF ENABLE
# This template shows an example on how to use azure-appliction-gateway module to deploy Azure Appliction Gateway.
##########################################################################################################################

terraform {
  required_version =">=0.13.0"
}

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id = "${var.client_id}"
  client_secret = "${var.secret_access_key}"
  tenant_id = "${var.tenant_id}"
}

##########################################################################################################################
# CREATE THE NECESSARY NETWORK RESOURCES FOR THE EXAMPLE
##########################################################################################################################

# Resource Group
resource "azurerm_resource_group" "app_gateway" {
  name     = var.resource_group_name
  location = var.resource_location
}

# virtual network
resource "azurerm_virtual_network" "app_gateway" {
  name                = var.virtual_network_name
  resource_group_name = azurerm_resource_group.app_gateway.name
  location            = var.resource_location
  address_space       = var.address_space
}

##########################################################################################################################
# DEPLOY THE AZURE APPLICATION GATEWAY
##########################################################################################################################

module "app_gateway" {
    # When using this module in your scripts, you have to use a Github url with a ref attribute that pins you to a 
    # specific version of the module, such as the following example:
    # 
    source ="./modules/application_gateway"
     
  
}