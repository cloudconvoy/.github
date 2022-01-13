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
