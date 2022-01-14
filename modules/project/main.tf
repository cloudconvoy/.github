locals {
  // Additional template parameters
  parameter_overrides = {
    repository = github_repository.this
  }

  template_path = "${path.module}/templates"
}

resource "github_repository" "this" {
  allow_merge_commit     = false
  allow_rebase_merge     = false
  allow_squash_merge     = true
  delete_branch_on_merge = true
  description            = var.description
  has_projects           = false
  has_wiki               = false
  name                   = var.name
  topics                 = concat(var.topics, ["terraform-managed"])
  visibility             = var.visibility
}

resource "github_repository_file" "this" {
  branch              = github_repository.this.default_branch
  content             = templatefile("${local.template_path}/README.md", local.parameter_overrides)
  file                = "README.md"
  overwrite_on_create = true
  repository          = github_repository.this.name
}
