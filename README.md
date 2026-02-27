# 40 Days Cloud & DevSecOps Sprint 🚀

This repository documents my 40-day intensive journey to master Cloud Engineering and DevSecOps, focusing on the AWS ecosystem and Infrastructure as Code (IaC).

## Day 1: Virtual Private Cloud (VPC) Foundations
Today I explored the core of AWS networking by building a custom VPC from scratch using Terraform.

### Technical Achievements:
- **Provider Configuration:** Set up the AWS provider for the `us-east-1` region.
- **VPC Design:** Defined a custom CIDR block (`10.0.0.0/16`) to understand network boundaries.
- **Resource Lifecycle:** Practiced the full cycle of `init`, `plan`, `apply`, and `destroy` to ensure clean environment management.


## Day 2: Network Architecture & Connectivity
Today, I moved beyond foundations to build a structured network, implementing segmentation and routing logic to ensure secure communication.

### Technical Achievements:
- **Subnetting & High Availability:** Designed and deployed a Public Subnet (us-east-1a) and a Private Subnet (us-east-1b). Using multiple Availability Zones (AZs) is the first step toward building fault-tolerant architectures.
- **Internet Gateway (IGW):** Provisioned an IGW to act as the VPC's communication bridge with the public internet.
- **Custom Routing Logic:** Created a Public Route Table and established an association with the Public Subnet, defining a default route (0.0.0.0/0) to the Internet Gateway.
- **State Management:** Successfully executed the Terraform lifecycle, managing resource dependencies (VPC -> IGW -> Route Table).

## Day 3: Security Groups & Stateful Defense
Today I implemented the first layer of active defense for cloud resources by configuring Security Groups as instance-level firewalls.

### Technical Achievements:
- **Security Group Provisioning:** Created a virtual firewall for EC2 instances to control inbound and outbound traffic.
- **Stateful Traffic Logic:** Explored the stateful nature of SGs, ensuring that authorized ingress traffic (Port 22/SSH) is automatically allowed to return without manual egress rules.
- **Inbound/Outbound Rules:** Configured precise Inbound rules for administrative access and allowed restricted Outbound traffic to enable system updates.

### Environment: 
- All tasks performed on **Fedora 43 Workstation**.

### Tools Used:
- Terraform v1.14+
- AWS CLI
- Linux (Fedora)