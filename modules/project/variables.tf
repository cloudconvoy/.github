variable "description" {
  default     = ""
  description = "A short description of the repository."
  type        = string
}

variable "gitignore_template" {
  default     = ""
  description = "Desired language or platform [.gitignore template](https://github.com/github/gitignore) to apply. Use the name of the template without the extension. For example, \"Haskell\"."
  type        = string
}

variable "name" {
  description = "The name of the repository."
  type        = string
}

variable "topics" {
  default     = []
  description = "An array of topics to add to the repository."
  type        = list(string)
}

variable "visibility" {
  default     = "private"
  description = "Can be `public` or `private`"
  type        = string

  validation {
    condition     = contains(["public", "private"], var.visibility)
    error_message = "Valid Values: public, private."
  }
}
