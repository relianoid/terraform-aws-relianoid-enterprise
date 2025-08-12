variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_availability_zone" {
  description = "AWS availability zone"
  type        = string
  default     = "us-east-1a"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "relianoid-vpc"
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
  default     = "relianoid-subnet"
}

variable "vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
  default     = "relianoid-vm"
}

variable "instance_type" {
  description = "AWS instance type"
  type        = string
  default     = "t3.medium"
}

variable "ami_id" {
  description = "Marketplace AMI ID"
  type        = string
}

variable "key_name" {
  description = "Name of the AWS key pair"
  type        = string
  default     = "relianoid-key"
}

variable "public_ssh_key_path" {
  description = "Path to your SSH public key file"
  type        = string
  default     = "id_rsa.pub"
}
