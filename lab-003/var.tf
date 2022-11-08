variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "host_ip" {
  type = "map"
  default = {
    "account1" = "devops1"
    "account2" = "devops2"
    "account3" = "devops3"
  }
}

variable "common_tags" {
  type = map(any)
  default = {
    ENV           = "lab"
    LAB_ID        = "lab-003"
    ALIAS_PROJECT = "Elastic Playground"
    MANAGED_BY    = "Terraform"
  }
}

