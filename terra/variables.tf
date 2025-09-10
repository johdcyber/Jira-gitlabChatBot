variable "profile" {
  description = "AWS profile to use for authentication"
  type    = string
  default = "default"
}

variable "region-master" {
  description = "AWS region for the master VPC"
  default     = "us-east-1"
  type        = string
}

variable "region-worker" {
  description = "AWS region for the worker VPC"
  default     = "us-east-2"
  type        = string
}