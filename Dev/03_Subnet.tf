####################### Subnet creation #############################################
resource "azurerm_subnet" "subnet" {
  name                 = "${var.application_name}${var.environment}-subnet"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = [var.subnet_prefix]
}