variable "region" {
  default = "sa-east-1"
  type = string
  description = "valor para região do ambiente"
}

variable "usuarios" {
  type    = list(string)
  default = []
}


