resource "aws_vpc" "dev" { 
  cidr_block = "${var.cidr_block}" 
  enable_dns_hostnames = true
  enable_dns_support = true
} 
