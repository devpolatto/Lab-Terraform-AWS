variable "common_tags" {
  type = map(any)
  default = {
    ENV           = "lab"
    LAB_ID        = "lab-003"
    ALIAS_PROJECT = ""
    MANAGED_BY    = "Terraform"
  }
}

