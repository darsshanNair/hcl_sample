# main.tf

provider "aws" {
  region = "us-east-1"  # Set your desired AWS region
}

resource "aws_vpc" "example_vpc" {
  cidr_block            = "10.0.0.0/16"
  enable_dns_support    = true
  enable_dns_hostnames  = true

  tags = {
    Name = "MyTerraformVPC"
  }
}

# ... (other resources)

resource "aws_instance" "example_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "your-key-pair-name"
  subnet_id     = aws_subnet.example_subnet_1.id

  tags = {
    Name = "MyTerraformEC2Instance"
  }

  # Using the idp_name variable
  user_data = <<-EOF
              #!/bin/bash
              echo "IDP Name: ${var.idp_name}" >> /tmp/idp_name.txt
              # Additional user data script
              EOF
}
