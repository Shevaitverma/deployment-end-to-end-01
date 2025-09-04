variable "project" {
description = "Project/name prefix"
type = string
default = "my-todo-app"
}


variable "aws_region" {
description = "AWS region"
type = string
default = "ap-south-1"
}


variable "vpc_cidr" {
description = "VPC CIDR"
type = string
default = "10.0.0.0/16"
}


variable "public_subnet_cidr" {
description = "Public subnet CIDR"
type = string
default = "10.0.1.0/24"
}


variable "az" {
description = "Availability zone"
type = string
default = "ap-south-1a"
}


variable "ssh_cidr" {
description = "Allowed CIDR for SSH"
type = string
default = "0.0.0.0/0" # change to your IP/CIDR for security
}


variable "key_name" {
description = "EC2 key pair name"
type = string
default = "test" # you can create key in console and refrence the name eg: backend-key.pem = backend-key
}


variable "ami" {
  description = "AMI ID for the instance"
  type = string
  default = "ami-0f918f7e67a3323f0"
}


variable "instance_type" {
description = "EC2 instance type"
type = string
default = "t2.micro"
}

