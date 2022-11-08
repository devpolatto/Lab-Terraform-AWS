variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "hosts_inventory" {
  type = list
  default = [
    {
      id = "host_1"
      hostname = "Elastic Server"
      ip = "192.168.20.10"
    },
    {
      id = "host_1"
      hostname = "Elastic Server"
      ip = "192.168.20.20"
    },
    {
      id = "host_1"
      hostname = "Elastic Server"
      ip = "192.168.20.30"
    }
  ]
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

