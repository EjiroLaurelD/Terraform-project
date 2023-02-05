
# Create a VPC
resource "aws_vpc" "altschool-terraform" {
  cidr_block           = var.vpc-cidr
  enable_dns_support   = true #gives you an internal domain name
  enable_dns_hostnames = true #gives you an internal host name    
  tags = {
    Name = "altschool-terraform"
  }
}

resource "aws_subnet" "public-subnet" {
  for_each                = var.public-subnets
  vpc_id                  = aws_vpc.altschool-terraform.id
  cidr_block              = each.value["cidr_block"]
  availability_zone       = each.value["azs"]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${each.key}"
  }
}

resource "aws_subnet" "private-subnet" {
  for_each          = var.private-subnets
  vpc_id            = aws_vpc.altschool-terraform.id
  cidr_block        = each.value["cidr_block"]
  availability_zone = each.value["azs"]
  tags = {
    Name = "private-subnet-${each.key}"
  }
}

/*count = length(var.vpc-private-subnets)
  vpc_id = aws_vpc.altschool-terraform.id
  cidr_block = element(var.vpc-private-subnets,count.index)
  availability_zone = element(var.azs,count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "private-subnet-${count.index+1}"
  }*/

/*resource "aws_subnet" "public-subnets" {
  for_each = toset(var.vpc-public-subnets)
  cidr_block = each.value
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.altschool-terraform.id

  tags = {
    "Name" = "terraform-public-azs"
  }
}


resource "aws_subnet" "private-subnet" {
  for_each = toset(var.vpc-public-subnets)
  cidr_block = each.value
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.altschool-terraform.id

  tags = {
    "Name" = "terraform-private-azs"
  }
}


/*resource "aws_subnet" "public-subnet1-terraform" {
  vpc_id     = aws_vpc.altschool-terraform.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true //it makes this a public subnet
  availability_zone = var.zone-a


  tags = {
    Name = "public-subnet-terraform"
  }
}*/
