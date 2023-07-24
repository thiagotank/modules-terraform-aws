# variables.tf

variable "name" {
  description = "Name tag for the security group."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created."
  type        = string

}

variable "ingress_rules" {
  description = "List of ingress rules for the security group."
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
}

variable "tags" {
  description = "Map of tags to be attached to the security group."
  type        = map(string)
  default     = {}
}