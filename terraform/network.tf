terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

# Create VPC
resource "aws_vpc" "vpc_master" {
  cidr_block          = "192.168.0.0/24"
  enable_dns_support  = true
  enable_dns_hostnames = true
  tags = {
    Name = "Main-vpc"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id   = aws_vpc.vpc_master.id
}

# Create subnet
resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.vpc_master.id
  cidr_block = "192.168.0.0/24"
}

# Create route for subent
resource "aws_route_table" "RTable" {
  vpc_id = aws_vpc.vpc_master.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
