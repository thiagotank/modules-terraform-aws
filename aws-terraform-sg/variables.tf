variable "name" {
  description = "Name tag for the security group."
  type        = string
}

variable "cost_center" {
  description = "Name tag for the security group."
  type        = string
  default     = "CC-SSD"
}

variable "bs" {
  description = "Name tag for the security group."
  type        = string
  default     = "PGX_SUPERDIGITAL"
}

variable "product" {
  description = "Name tag for the security group."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created."
  type        = string

}

variable "common_tags" {
  description = "Common tags to be applied to the security group."
  type        = map(string)
  default     = {}
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