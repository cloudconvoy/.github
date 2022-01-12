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
  secret_id     = aws_secretsmanager_secret.this.id
  version_stage = "AWSCURRENT"
}
