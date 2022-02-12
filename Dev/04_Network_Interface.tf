
########################### Network Interface Card #########################################
resource "azurerm_network_interface" "nic" {
  name                = "${var.application_name}${var.environment}NIC${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  count               = "${var.servercount}"

  ip_configuration {
    name                                    = "ipconfig${count.index}"
    subnet_id                               = azurerm_subnet.subnet.id
    private_ip_address_allocation           = "Dynamic"
    public_ip_address_id                    = "${element(azurerm_public_ip.pip.*.id, count.index )}"
  }
}