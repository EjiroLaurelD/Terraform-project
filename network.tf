resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.altschool-terraform.id

  tags = {
    Name = "terraforn-igw"
  }
}
resource "aws_route_table" "terraform-route-table" {
  vpc_id = aws_vpc.altschool-terraform.id

  route {
    cidr_block = "0.0.0.0/0" //subnet can reach anywhere
    gateway_id = aws_internet_gateway.terraform-igw.id
  }
  tags = {
    Name = "terraform-routetable"
  }
}

resource "aws_route_table_association" "public-route-table" {
  for_each = aws_subnet.public-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.terraform-route-table.id
}

/*resource "aws_security_group" "instance-sg" {
  name        = "terraform-instance-sg"
  description = "inbound rules for instances"
  vpc_id = aws_vpc.altschool-terraform.id
  dynamic "ingress" {
    for_each = local.inbound_rules
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      security_groups = [aws_security_group.alb-sg.id]
    }
  }
  ingress =  {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow ssh to instance"
    from_port = 0
    to_port = 0
    protocol = "tcp"
  } 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]

  } 
}*/
resource "aws_security_group" "instance-sg" {
  vpc_id = aws_vpc.altschool-terraform.id
  dynamic "ingress" {
    for_each = local.inbound_rules
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]

  }

  tags = {
    Name = "terraform-instance-sg"
  }
}

