variable "region" {
    description = "region for hosting production"
    default = "us-east-1"  
}
variable "vpc-cidr" {
  type = string
  default = "10.0.0.0/16"
}
variable "private-subnets" {
  description = "private subnets for vpc"
type = map(object({
    cidr_block = string
    azs = string
  }))
}

variable "public-subnets" {
  description = "public subnets for vpc"
  type = map(object({
    cidr_block = string
    azs = string
  }))
}

variable "key_name" {
 description = "Enter the path to the SSH Public Key to add to AWS."
 default = "ansiblenew"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "amis" {
 description = "Base AMI to launch the instances"
 default = {
    us-east-1 = "ami-00874d747dde814fa"
 }
}

variable "inbound-rules" {
  type = list(number)
  default = [80,443,22]
}

variable "elb-rules" {
  type = list(number)
  default = [80,443]
  
}

variable "domain_name" {
  type = string
  default = "ejirolaureld.live"
}

