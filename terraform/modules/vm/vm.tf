resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}-ni"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}-vm"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_DS2_v2"
  admin_username      = "${var.admin_username}"
  admin_password      = "${var.admin_password}"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.test.id]
  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/HuTa8pR7c59Lfeoo6Kp14wAPkFTuggZ4Pod1pEVpPwoMyeKzTxjswp9nGzDuI3LViQTU/qk+GI+uyp3g6QUk2y4A+nM5gLHg+sK5s1H3MDdJFMl+1tCx+2BHaXwcWlqtCZJTjeQ2GjyH9OjEnGlH5brT5r5t5P2YgGqdnoErH5FM+sjGBwq2fil2of3s9Fp5KgjAO/iqufgpzBk+0m006Wa8LGQU+Xw30qA/+QP6YCiN5p2Wis70eCXO4ENPgBIZGyQq7rP5silNOa4MAv95BXWMqN+Y6Z9RdTDee48Y7K4a5KqFoRH/gL/8kOlu1XU25ZKpngbFMYe03pYrFdmacdRB+nAvsczvouKRA6A9uTkIqN3DR//9t96pZ8dTYATS9S0ogP81Fnjpkd7RuD4vqaMaVISyDE/lGPSvK3nhVmAFZGa4RqBPJwLqPJhzELbkq3o/3NJX4A/lq+dFJ1kLvrTtTVoC7kgTzaCNQtGLS4oSwmWnSHqmS+X735saDWs= devopsagent@locLinuxVM"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
