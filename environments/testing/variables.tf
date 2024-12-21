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

variable "instance_type" {
  type        = string
  description = "The EC2 instance type"
}

variable "ami_id" {
  type        = string
  description = "The AMI ID for launching the EC2 instance"
}

variable "key_pair" {
  type        = string
  description = "The key pair to associate with the EC2 instance"
}

variable "iam_instance_profile" {
  type        = string
  description = "The IAM instance profile to associate with the EC2 instance"
}

variable "script_name" {
  type        = string
  description = "The name of the script to run on the EC2 instance"
}

variable "instance_name" {
  type        = string
  description = "The name of the EC2 instance"
}

variable "dashboard_name" {
  default = "EC2MonitoringDashboard"
}

variable "instance_id" {
  description = "ID of the EC2 instance to monitor"
  type        = string
}