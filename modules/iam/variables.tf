variable "app_name" {
  type        = string
  description = "The name of the application"
}

variable "environment" {
  type        = string
  description = "The environment in which the application is running (e.g., dev, prod)"
}

variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}