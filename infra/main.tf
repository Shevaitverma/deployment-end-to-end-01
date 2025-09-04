provider "aws" {
region = var.aws_region
}

# --- Networking (minimal VPC with 1 public subnet) ---
resource "aws_vpc" "main" {
cidr_block = var.vpc_cidr
enable_dns_support = true
enable_dns_hostnames = true
tags = { Name = "${var.project}-vpc" }
}


resource "aws_internet_gateway" "igw" {
vpc_id = aws_vpc.main.id
tags = { Name = "${var.project}-igw" }
}


resource "aws_subnet" "public" {
vpc_id = aws_vpc.main.id
cidr_block = var.public_subnet_cidr
map_public_ip_on_launch = true
availability_zone = var.az
tags = { Name = "${var.project}-public-subnet" }
}


resource "aws_route_table" "public" {
vpc_id = aws_vpc.main.id
tags = { Name = "${var.project}-public-rt" }
}


resource "aws_route" "internet_access" {
route_table_id = aws_route_table.public.id
destination_cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.igw.id
}


resource "aws_route_table_association" "public" {
subnet_id = aws_subnet.public.id
route_table_id = aws_route_table.public.id
}

# --- Security group ---
resource "aws_security_group" "backend_sg" {
name = "${var.project}-backend-sg"
description = "Allow HTTP/HTTPS/SSH"
vpc_id = aws_vpc.main.id


ingress {
description = "HTTP"
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


ingress {
description = "HTTPS"
from_port = 443
to_port = 443
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


ingress {
description = "SSH"
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = [var.ssh_cidr]
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}


tags = { Name = "${var.project}-backend-sg" }
}


resource "aws_instance" "backend" {
ami = var.ami
instance_type = var.instance_type
vpc_security_group_ids = [aws_security_group.backend_sg.id]
subnet_id = aws_subnet.public.id
tags = { Name = "${var.project}-backend" }
key_name = var.key_name
}

output "public_ip" {
value = aws_instance.backend.public_ip
description = "Public IP of the backend server"
}


output "backend_url" {
value = "http://${aws_instance.backend.public_ip}"
description = "Base URL for the backend (HTTP)"
}