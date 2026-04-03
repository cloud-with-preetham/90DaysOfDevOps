variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "terraweek"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ingress_ports" {
  description = "Ingress port for the security group"
  type        = list(number)
}
