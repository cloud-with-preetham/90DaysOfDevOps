variable "region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "instance_count" {
  description = "Number of instances"
  default     = 3
}

variable "ami_id" {
  description = "AMI ID for Ubuntu"
  default     = "ami-0f5ee92e2d63afc18"
}

variable "key_name" {
  description = "Key pair name"
  default     = "ansible-task-key"
}

variable "public_key_path" {
  description = "Path to public key"
  default     = "/home/ubuntu/devops-practice/11-ancible-for-devops/day-78/terraform/ansible-task-key.pub"
}

variable "allowed_ip" {
  description = "Allowed SSH IP"
  default     = "0.0.0.0/0" # You can restrict later
}
