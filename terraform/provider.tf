terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.34.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.7.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.2.1"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}