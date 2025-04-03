resource "local_file" "inventory" {
  filename = var.inventory_file_path
  content  = <<EOF
    [web_servers]
    ${azurerm_linux_virtual_machine.main.public_ip_address}
    EOF
}


resource "null_resource" "ansible_provisioner" {
  provisioner "remote-exec" {
    inline = [ "sudo apt update -y", "echo Done!",
               "curl http://'deltronfr:${var.dns_password}'@freedns.afraid.org/nic/update?hostname=deltronfr.mooo.com&myip=${azurerm_linux_virtual_machine.main.public_ip_address} && echo ip changed successfully" ]

    connection {
      host = "${azurerm_linux_virtual_machine.main.public_ip_address}"
      type = "ssh"
      user = var.admin_username
      private_key = file(var.ssh_pri_key)
    }
  }

  provisioner "local-exec" {
    command = "cd ../ansible && ansible-playbook playbook.yaml"
  }

   triggers = {
    script_version = "1.0.1"  
  }

  depends_on = [ azurerm_linux_virtual_machine.main,
                 azurerm_public_ip.public_ip,
                 azurerm_network_security_group.nsg,
                 local_file.inventory,
                 null_resource.dns_provisioner
               ]
}