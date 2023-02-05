#IP of aws instance copied to a file host-inventory in local system
/*resource "local_file" "host-inventory" {
    filename = "./host-inventory"
    content = "echo '${self.public_ip}' > ~/terraform/altschool/ansible"
}


#copying the hos inventory file file to the Ansible control node from local system 

resource "null_resource" "ansible" {
depends_on = [aws_instance.web]
provisioner "remote-exec" {
    inline = [
        "cd ~/terraform/altschool/ansible",
        "ansible-playbook main.yml"  
    ] 
       }
}
*/