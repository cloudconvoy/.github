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
  token = data.aws_secretsmanager_secret_version.this.secret_string
}

data "aws_secretsmanager_secret" "this" {
  name = "GITHUB_TOKEN"
}

data "aws_secretsmanager_secret_version" "this" {
  secret_id     = data.aws_secretsmanager_secret.this.id
  version_stage = "AWSCURRENT"
}

resource "github_repository" "this" {
  for_each = {
    for repository in jsondecode(file("${path.module}/repositories.json")) :
    repository.name => repository
  }

  allow_merge_commit = false
  allow_rebase_merge = false
  allow_squash_merge = true
  has_projects       = false
  has_wiki           = false
  name               = each.key
}
