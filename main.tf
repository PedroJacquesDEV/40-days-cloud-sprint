# Define the "Cloud Provider"
provider "aws" {
    region = "us-east-1"
}

# Create your custom "Hidden Leaf Village" (VPC)
resource "aws_vpc" "main_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "Vila-da-Folha-Custom"
        Project = "Avante-Sprint"
    }
}