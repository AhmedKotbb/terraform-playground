variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The region to deploy the VPC in"
}

variable "name_prefix" {
  type        = string
  description = "The prefix to use for the resources"
  default     = "vpc-lab"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.42.0.0/16"
}

variable "azs" {
  type        = list(string)
  description = "The availability zones to deploy the VPC in"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "The CIDR blocks for the public subnets"
  default     = ["10.42.1.0/24", "10.42.2.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "The CIDR blocks for the private subnets"
  default     = ["10.42.11.0/24", "10.42.12.0/24"]
}

variable "create_nat_per_az" {
  type        = bool
  description = "create a NAT gateway per availability zone (true) or a single NAT gateway (false)"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "The tags to add to the resources"
  default = {
    Environment = "Development"
    Project     = "VPC Lab"
    Owner       = "Ahmed Kotb"
    Team        = "DevOps"
  }
}