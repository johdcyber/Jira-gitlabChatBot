variable "profile" {
  description = "AWS profile to use for authentication"
  type        = string
  default     = "default"
  
  validation {
    condition     = length(var.profile) > 0
    error_message = "AWS profile cannot be empty."
  }
}

variable "region-master" {
  description = "AWS region for the master VPC"
  type        = string
  default     = "us-east-1"
  
  validation {
    condition = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.region-master))
    error_message = "Region must be a valid AWS region format (e.g., us-east-1)."
  }
}

variable "region-worker" {
  description = "AWS region for the worker VPC"
  type        = string
  default     = "us-east-2"
  
  validation {
    condition = can(regex("^[a-z]{2}-[a-z]+-[0-9]$", var.region-worker))
    error_message = "Region must be a valid AWS region format (e.g., us-east-2)."
  }
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "jenkins-infrastructure"
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]+$", var.project_name))
    error_message = "Project name can only contain alphanumeric characters and hyphens."
  }
}

variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs"
  type        = bool
  default     = true
}

variable "flow_logs_retention_days" {
  description = "Number of days to retain VPC Flow Logs"
  type        = number
  default     = 30
  
  validation {
    condition     = var.flow_logs_retention_days >= 1 && var.flow_logs_retention_days <= 3653
    error_message = "Flow logs retention must be between 1 and 3653 days."
  }
}