###################### Resource Group Creation #################################
resource "azurerm_resource_group" "rg" {
  name        = "${var.application_name}${var.environment}RSG"
    location    =  var.location                                 
}