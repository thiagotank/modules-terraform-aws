module "security_group" {
  source             = "./aws-sltools-sg/"
  name               = "Rendafixa"
  vpc_id             = "vpc-0e66de74"

 ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow ingress on HTTP"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["203.0.113.1/32"]
      description = "Allow ingress on SSH"
    },
    {
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_blocks = ["203.0.113.1/32"]
      description = "Allow ingress on RDP"
    },
  ]

  tags = {
    Environment = "Production"
    Team        = "DevOps"
    ManagedBy   = "Terraform"
    # Outras tags personalizadas podem ser adicionadas aqui
  }
}