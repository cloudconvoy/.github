terraform {
  backend "s3" {
    bucket         = "cloudconvoy"
    dynamodb_table = "cloudconvoy"
    encrypt        = true
    key            = "projects/.github/terraform.tfstate"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "github" {
  owner = "cloudconvoy"
  token = data.aws_ssm_parameter.this.value
}

data "aws_ssm_parameter" "this" {
  name            = "/aws/reference/secretsmanager/GITHUB_TOKEN"
  with_decryption = true
}

module "project" {
  for_each = {
    for repository in jsondecode(file("${path.module}/repositories.json")) :
    repository.name => repository
  }
  source = "./modules/project"

  description        = lookup(each.value, "description", "")
  gitignore_template = lookup(each.value, "gitignore_template", "")
  name               = each.key
  topics             = lookup(each.value, "topics", [])
  visibility         = lookup(each.value, "visibility", "private")
}
