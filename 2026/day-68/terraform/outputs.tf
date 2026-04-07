
output "instance_ips" {
  value = aws_instance.servers[*].public_ip
}
