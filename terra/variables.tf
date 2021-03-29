variable "profile" {
  type    = string
  default = "default"
}

variable "region-master" {
  default     = "us-east-1"
  description = "This will be the main vpc for the master"
  type        = string
}

variable "region-worker" {
  default     = "us-east-2"
  description = "This will be the main VPC for Jenkins"
  type        = string
}
variable "zones-master" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}

variable "zones-worker" {
  default = ["us-east-2a", "us-east-2b", "us-east-2c", "us-east-2d"]
}