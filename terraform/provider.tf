terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    namedotcom = {
      source  = "lexfrei/namedotcom"
      version = "1.2.4"

    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}

#Configure domain name provider name.com
provider "namedotcom" {
  token = var.namedotcom-token
  username = var.namedotcom-username
}
