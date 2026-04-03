variable "vpc_id" {
  description = "ID of the VPC to which the security group belongs"
  type        = string
}

variable "ingress_ports" {
  description = "List of ingress ports"
  type        = list(number)
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}
