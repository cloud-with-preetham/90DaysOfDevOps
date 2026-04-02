output "instance_id" {
  value = aws_instance.day65_instance.id
}

output "public_ip" {
  value = aws_instance.day65_instance.public_ip
}

output "private_ip" {
  value = aws_instance.day65_instance.private_ip
}
