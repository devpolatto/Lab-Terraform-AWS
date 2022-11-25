output "Ec2-Master" {
  value = {
     "Master" : "Access --- ssh -i '${aws_key_pair.key_pair.key_name}.pem' ubuntu@${aws_instance.master.public_ip}"
  }
}

output "Nodes-K8s" {
  value = {
     for v in aws_instance.node: v.tags.Name => "ssh -i '${aws_key_pair.key_pair.key_name}.pem' ubuntu@${v.public_ip}"
  }
}