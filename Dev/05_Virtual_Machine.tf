
####################  Virtual Machine Creation #######################################################
resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.application_name}${var.environment}VM${count.index + 1}"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  vm_size               = var.vm_size
  network_interface_ids = ["${element(azurerm_network_interface.nic.*.id, count.index)}"]
  count                 = var.servercount

  storage_image_reference {
    publisher   = var.image_publisher
    offer       = var.image_offer
    sku         = var.image_sku
    version     = var.image_version
  }

  storage_os_disk {
    name              = "${var.application_name}${var.environment}-OSDisk${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${format("${var.application_name}${var.environment}vm%03d", count.index + 1)}"
    admin_username =  var.admin_username
    admin_password =  var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
resource "azurerm_virtual_machine_extension" "example" {
  count                = var.servercount
  name                 = "Website"
  virtual_machine_id   = azurerm_virtual_machine.vm[count.index].id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "commandToExecute": "sudo apt-get install apache2 -y && sudo rm -rf /var/www/html/* && sudo wget https://raw.githubusercontent.com/syamchanakya/Azure/master/index.html -P /var/www/html/"
    }
SETTINGS
  tags = {
    Project_Name  = var.application_name
    Project_Owner = var.projectowner_name
  }
}
