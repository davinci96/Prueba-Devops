variable "app_name" {
  type        = string
  description = "The name of the application"
}

variable "environment" {
  type        = string
  description = "The environment in which the application is running (e.g., dev, prod)"
}

variable "region" {
  type        = string
  description = "The AWS region where the resources will be deployed"
}

variable "ip_address_prefix" {
  type        = string
  description = "The prefix of the IP address for the VPC and subnets (e.g., 10.0)"
}

variable "dev_ip_address" {
  type        = string
  description = "The IP address of the developer for SSH access to the EC2 instance"
}
