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

# 1. Internet Gateway (0 Door of the villa)

resource "aws_internet_gateway" "main_igw"{
    vpc_id = aws_vpc.main_vpc.id
    tags = { Name = "main-igw"}
}

# 2. Public Subnet (Principal Door)

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"
    tags = { Name = "public-subnet"}
}

# 3. Private Subnet (Secrect District)

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
    tags = { Name = "private-subnet"}
}

# 4. Public Route Table 
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_igw.id
    }

    tags = { Name = "public-rt"}
}

# 5. Associantion (Calling route table to the public subnet)

resource "aws_route_table_association" "public_associ" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}