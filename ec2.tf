data "aws_ami" "ubuntu" {
  most_recent = true
  owners =["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_key_pair" "ansiblenew" {
  key_name           = "ansiblenew"
  include_public_key = true
}

output "fingerprint" {
  value = data.aws_key_pair.ansiblenew.fingerprint
}

output "name" {
  value = data.aws_key_pair.ansiblenew.key_name
}

output "id" {
  value = data.aws_key_pair.ansiblenew.id
}

resource "aws_instance" "web" {
  for_each = aws_subnet.public-subnet
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = aws_subnet.public-subnet[each.key].id
  #availability_zone = aws_vpc.altschool-terraform.id
  vpc_security_group_ids = [aws_security_group.instance-sg.id]
  #vpc_zone_identifier  = [for azs in aws_subnet.public-subnet: azs.id]
  associate_public_ip_address = true
    tags = {
      "Name" = "web-${each.key}"
    }  
  provisioner "local-exec" {
    command = "echo '${self.public_ip}' >> ~/terraform/altschool/ansible/host-inventory"
    
 }
}

/*resource "null_resource" "ansible-playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook ~/terraform/altschool/ansible/main.yml"  
  }
  depends_on = [
    aws_instance.web
  ]
}

/*
resource "tls_private_key" "terraform" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "terraformkey" {
  key_name = var.key_name
  public_key = tls_private_key.terraform.public_key_openssh
}

resource "local_file" "key-name" {
  content = tls_private_key.terraform.private_key_pem
  filename = "${var.key_name}.pem"
  file_permission = "0400"
}
*/
### Creating Security Group for EC2

## Creating Launch Configuration
/*resource "aws_launch_template" "terraform-ec2" {
  image_id = "${lookup(var.amis,var.region)}"
  instance_type  = "t2.micro"
  #security_groups        = 
  key_name  = var.key_name
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
              EOF
              
  lifecycle {
    create_before_destroy = true
  }
}
*/
/*resource "aws_autoscaling_group" "asg" {
  name                 = "terraform-asg-"
  launch_configuration = "aws_launch_template.terraform-ec2"
  min_size             = 3
  max_size             = 3

  lifecycle {
    create_before_destroy = true
  }
}*/
