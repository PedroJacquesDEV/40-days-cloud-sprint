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

# 6. Security Group - The Sand Shield
resource "aws_security_group" "ssh_access" {
    name = "allow-ssh"
    description = "Allow SSH inbound traffic"
    vpc_id = aws_vpc.main_vpc.id

# Inbound Rules (Ingress)
ingress {
    description = "SSH from thhe world"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # EM PRODUÇÃO: Use only real IP (/32)
}  

#Outbound Rules (Egress)
egress {
    from_port = 0
    to_port = 0
    protocol = "-1" # Permit all protocls for exit
    cidr_blocks = ["0.0.0.0/0"] 
}

tags = {
    Name = "allow-ssh-sg"
}

}

# EC2 instance "calling" the resources:
resource "aws_instance" "cork_server" {
  ami           = "ami-0c1c30571d2dae5c9" 
  instance_type = "t3.micro"
  
  subnet_id              = aws_subnet.public_subnet.id      # Connecting to Subnet
  vpc_security_group_ids = [aws_security_group.ssh_access.id] # Using "Sand Shield"
  

  key_name      = aws_key_pair.deployer.key_name

  tags = {
    Name = "Shinobi-Server"
  }
}