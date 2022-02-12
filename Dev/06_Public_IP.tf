
##################  Public IP creation #############################################

resource "azurerm_public_ip" "pip" {
  count               = var.servercount
  name                = "${var.application_name}${var.environment}-PIP${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}