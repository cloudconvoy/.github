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
  auto_init              = true
  delete_branch_on_merge = true
  description            = var.description
  has_projects           = false
  has_wiki               = false
  name                   = var.name
  topics                 = concat(var.topics, ["terraform-managed"])
  visibility             = var.visibility
}

// https://api.github.com/users/github-actions[bot]
// https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-github-user-account/managing-email-preferences/setting-your-commit-email-address
resource "github_repository_file" "this" {
  for_each = fileset("${path.module}/templates", "**")

  branch              = github_repository.this.default_branch
  commit_author       = "github-actions[bot]"
  commit_email        = "41898282+github-actions[bot]@users.noreply.github.com"
  content             = templatefile("${local.template_path}/${each.value}", local.parameter_overrides)
  file                = each.value
  overwrite_on_create = true
  repository          = github_repository.this.name
}
