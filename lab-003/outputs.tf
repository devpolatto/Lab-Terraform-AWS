output "subnet" {
  value = {for k, v in aws_subnet.this : v.tags.Name => v.id}
}