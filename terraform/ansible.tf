resource "null_resource" "inventory" {

  provisioner "local-exec" {
    command =  "echo [web_servers] > ../ansible/inventory.ini && echo ${azurerm_linux_virtual_machine.main.public_ip_address} >> ../ansible/inventory.ini"
  }
  triggers = {
    script_version = "1.0.2"  
  }
    }
    


resource "null_resource" "ansible_provisioner" {
  provisioner "remote-exec" {
    inline = [ "sudo apt update -y", "echo Done!",
               "curl http://'deltronfr:${var.dns_password}'@freedns.afraid.org/nic/update?hostname=deltronfr.mooo.com&myip=${azurerm_linux_virtual_machine.main.public_ip_address} && echo Success && sleep 7" ]

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
    script_version = "1.0.2"  
  }

  depends_on = [ azurerm_linux_virtual_machine.main,
                 azurerm_public_ip.public_ip,
                 azurerm_network_security_group.nsg,
               ]
}
