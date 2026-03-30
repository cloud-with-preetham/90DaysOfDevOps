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

resource "aws_s3_bucket" "jamil-mamu-ki-bucket" {
  bucket = "terraweek-preetham-2026"
}

resource "aws_instance" "terraform-practice" {
  ami = "ami-0ec10929233384c7f"
  instance_type = "t3.micro"

  tags = {
    Name = "terraweek-practice"
  }
}
