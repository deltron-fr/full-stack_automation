resource "local_file" "inventory" {
  filename = var.inventory_file_path
  content  = <<EOF
    [web_servers]
    ${azurerm_linux_virtual_machine.main.public_ip_address}
    EOF
}