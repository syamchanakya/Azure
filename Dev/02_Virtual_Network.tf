
##################  Virtual Network Creation ########################################
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.application_name}${var.environment}-vnet"
  location            = azurerm_resource_group.rg.location
  address_space       = [var.address_space]
  resource_group_name = azurerm_resource_group.rg.name
}