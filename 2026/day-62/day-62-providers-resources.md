# Day 62 – Providers, Resources and Dependencies

## What I Did Today

Today I built a complete AWS networking infrastructure using Terraform. I created a VPC, Subnet, Internet Gateway, Route Table, Route Table Association, Security Group, and an EC2 instance. I also learned how Terraform understands dependencies between resources and in which order it creates infrastructure.

---

## Task 1 – AWS Provider

I created a `providers.tf` file to configure the AWS provider and pin the provider version.

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

### Version Constraint

- `~> 5.0` means Terraform will install versions >= 5.0 and < 6.0
- `>= 5.0` means any version greater than 5.0
- `= 5.0.0` means only exactly version 5.0.0

I also understood that `.terraform.lock.hcl` locks the provider version so Terraform installs the same version every time.

---

## Task 2 – Build VPC from Scratch

I created the main infrastructure in `main.tf`.

```hcl
# VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "TerraWeek-VPC"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "TerraWeek-Public-Subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "TerraWeek-IGW"
  }
}

# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "TerraWeek-Route-Table"
  }
}

# Route Table Association
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}
```

After running `terraform plan`, Terraform showed the order in which resources would be created.

---

## Task 3 – Implicit Dependencies

I learned that Terraform automatically understands dependencies when one resource references another resource.

Examples from my code:

- Subnet depends on VPC → `aws_vpc.main.id`
- Internet Gateway depends on VPC
- Route Table depends on Internet Gateway
- Route Table Association depends on Subnet and Route Table

This is called **implicit dependency**.

If Terraform tried to create the subnet before the VPC, AWS would return an error because the VPC would not exist.

---

## Task 4 – Security Group and EC2 Instance

Then I created a Security Group and EC2 instance.

```hcl
# Security Group
resource "aws_security_group" "sg" {
  name   = "TerraWeek-SG"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "TerraWeek-SG"
  }
}

# EC2 Instance
resource "aws_instance" "main" {
  ami                         = "ami-xxxxxxxx"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "TerraWeek-Server"
  }
}
```

After applying, the EC2 instance was created inside the subnet with a public IP.

---

## Task 5 – Explicit Dependencies

Then I created an S3 bucket and used `depends_on`.

```hcl
resource "aws_s3_bucket" "logs" {
  bucket = "terraw-week-logs-bucket"

  depends_on = [aws_instance.main]
}
```

This is called **explicit dependency** because Terraform cannot automatically detect this dependency.

Real example: Sometimes we want a resource to be created only after another resource is fully ready.

---

## Task 6 – Lifecycle Rules

I added lifecycle rules to the EC2 instance.

```hcl
lifecycle {
  create_before_destroy = true
}
```

Lifecycle arguments I learned:

- `create_before_destroy` → Create new resource before deleting old one
- `prevent_destroy` → Prevent accidental deletion
- `ignore_changes` → Ignore changes made outside Terraform

---

## Terraform Dependency Graph

I used this command to generate the dependency graph:

```bash
terraform graph | dot -Tpng > graph.png
```

Terraform creates resources in dependency order and destroys them in reverse order.

---

## What I Learned

Today I learned:

- How to use Terraform AWS provider
- How to create a VPC and networking components using Terraform
- What implicit dependencies are
- What explicit dependencies are using `depends_on`
- Terraform lifecycle rules
- How Terraform decides resource creation order

This helped me understand how real infrastructure is built using Terraform and how resources are connected to each other.
