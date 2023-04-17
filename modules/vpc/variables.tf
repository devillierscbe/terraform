variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_sub_1_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_sub_1_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "pub_availability_zones" {
  type        = string
  default     = "ap-south-1a"
  description = "AZ for public subnet"
}

variable "pri_availability_zones" {
  type        = string
  default     = "ap-south-1b"
  description = "AZ for private subnet"
}
