provider "aws" {
    region = "ap-southeast-1"
    access_key = "AKIAROMDZXFZJO4SVNOH"
    secret_key = "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"  
}

#Create VPC 
resource "aws_vpc" "first-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Production"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.first-vpc.id #refer to line 8
  cidr_block = "10.0.1.0/24"
  tags = {
    "Name" = "prod-subnet"
  }
  
}