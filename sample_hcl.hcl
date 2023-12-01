/*
    Create an AWS VPC (Virtual Private Cloud) with subnets, security groups, and an EC2 instance.
    
    1. Configure providers
    2. Create Virtual Private Cloud (VPC)
    3. Create Subnet 1
    4. Create Subnet 2
    5. Create security groups
    6. Create EC2 Instance
*/

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "example_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyTerraformVPC"
  }
}

resource "aws_subnet" "example_subnet_1" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "MyTerraformSubnet1"
  }
}

resource "aws_subnet" "example_subnet_2" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "MyTerraformSubnet2"
  }
}

resource "aws_security_group" "example_security_group" {
  vpc_id = aws_vpc.example_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MyTerraformSecurityGroup"
  }
}

resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"   // Amazon Machine Image
  instance_type = "t2.micro"                // EC2 Instance type
  key_name      = "my-aws-key-pair"         // Key-pair for EC2 instance
  subnet_id     = aws_subnet.example_subnet_1.id

  security_group_names = [aws_security_group.example_security_group.name] // Security groups to be called

  tags = {
    Name = "MyTerraformEC2Instance"
  }
}
