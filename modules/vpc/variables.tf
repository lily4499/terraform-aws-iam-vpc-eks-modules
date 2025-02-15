variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnet configurations"
  type = list(object({
    cidr = string
    az   = string
    name = string
  }))
}

variable "private_subnets" {
  description = "A list of private subnet configurations"
  type = list(object({
    cidr = string
    az   = string
    name = string
  }))
}

variable "create_nat_gateway" {
  description = "Flag to create a NAT Gateway"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to resources"
  type        = map(string)
  default     = {}
}

