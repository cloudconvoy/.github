terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.71.0"
    }
    github = {
      source  = "integrations/github"
      version = "4.19.1"
    }
  }
  required_version = ">= 1.0"
}
