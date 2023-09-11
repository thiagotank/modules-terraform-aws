variable "organization" {
  type    = string
  
}

variable "environment" {
  type    = string
  
}

variable "vpc_cidr_block" {
  type    = string
 
}

variable "cidr_subnet_public" {
  type    = list(any)
  default = [{}]

}

variable "cidr_subnet_private" {
  type    = list(any)
  default = [{}]
}

variable "additional_tags" {
  default = {
    Organization = "$var.organization"
    ManagedBy    = "terraform"
    Environment = "$var.environment" }

  description = "Additional resource tags"
  type        = map(string)

}
