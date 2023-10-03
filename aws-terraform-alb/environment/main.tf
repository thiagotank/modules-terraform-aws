locals {
  # Variáveis Comuns
  common_tags = {
    cia           = var.cia
    TS            = var.ts
    tracking_code = var.tracking_code
  }

}

# Modulo security group
module "sg" {
  source = "../../aws-terraform-sg"

  name        = var.name
  vpc_id      = var.vpc_id
  product     = var.product
  common_tags = local.common_tags

  ingress_rules = var.ingress_rules
}

# Modulo Aplication Loadbalancer
module "alb" {
  source = "../"

  name               = var.name
  product            = var.product
  load_balancer_type = var.load_balancer_type
  internal           = var.internal
  vpc_id             = var.vpc_id
  subnets            = var.subnets
  security_groups    = module.sg.security_group_ids
  common_tags        = local.common_tags
  


  target_groups        = var.target_groups
  https_listeners      = var.https_listeners
  https_listener_rules = var.https_listener_rules
}