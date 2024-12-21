variable "app_name" {
  type        = string
  description = "The name of the application"
}

variable "environment" {
  type        = string
  description = "The environment in which the application is running (e.g., dev, prod)"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "security_group_id" {
  type        = list(string)
  description = "The security group IDs to apply to the EC2 instance"
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID"
}

variable "availability_zone" {
  type        = string
  description = "The availability zone"
}

variable "instance_type" {
  type        = string
  description = "The EC2 instance type"
}

variable "ami_id" {
  type        = string
  description = "The AMI ID for launching the EC2 instance"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "Whether to associate a public IP address with the EC2 instance"
}

variable "root_volume_type" {
  type        = string
  description = "The volume type for the root block device"
}

variable "root_volume_size" {
  type        = string
  description = "The size in GB for the root block device"
}

variable "root_iops" {
  type        = string
  description = "The number of IOPS for the root block device"
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