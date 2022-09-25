variable "instance_tags_nginx" {
  description = "lab id default values"
  type        = map(any)

  default = {
    Name   = "ngix-web-server"
    lab_id = "lab-001"
  }
}

variable "instance_tags_dns" {
  description = "lab id default values"
  type        = map(any)

  default = {
    Name   = "dns-server"
    lab_id = "lab-001"
  }
}