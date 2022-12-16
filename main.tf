terraform {
  backend "http" {}
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "3.20.0"
    }
  }
}

variable "gitlab_token" {}

provider "gitlab" {
  base_url = "https://gitlab.sikademo.com/api/v4/"
  token    = var.gitlab_token
}

locals {
  unprotected = {
    MY_B       = "222"
    MY_C       = "333"
    MY_CZ      = "Prague"
    MY_DE      = "Berlin"
    MY_FR      = "Paris"
    MY_IT      = "Rome"
    MY_XXX_BAR = "bar-bar-bar"
  }
  protected = {
    MY_A       = "111aaaaa"
    MY_TOKEN_A = "this-is-token-a"
    MY_XXX_FOO = "foo-foo-foo"
  }
}

resource "gitlab_project_variable" "project_3_unprotected_variables" {
  for_each = local.unprotected

  project   = "3"
  key       = each.key
  value     = each.value
  protected = false
}

resource "gitlab_project_variable" "project_3_protected_variables" {
  for_each = local.protected

  project   = "3"
  key       = each.key
  value     = each.value
  protected = true
  masked    = true
}
