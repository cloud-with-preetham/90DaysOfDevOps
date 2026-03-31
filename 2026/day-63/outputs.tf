output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "EC2 Instance Public IP"
  value       = aws_instance.main.public_ip
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = aws_subnet.public.id
}

output "instance_public_dns" {
  description = "EC2 Instance Public DNS"
  value       = aws_instance.main.public_dns
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.sg.id
}
