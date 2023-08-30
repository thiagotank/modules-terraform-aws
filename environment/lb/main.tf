locals {
  # Variáveis Comuns
  common_tags = {
    cia           = "BMM"
    TS            = "Observability"
    tracking_code = "SSD"
  }

#   product_name = "monito"
#   vpc_id       = "vpc-XXXX"
#   subnets      = ["subnet-XXXX", "subnet-XXXX"]
}

# Modulo security group
module "sg" {
  source = "./../../aws-terraform-sg"

  name        = var.name
  vpc_id      = var.vpc_id
  product     = var.product_name
  common_tags = local.common_tags

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
  ]

}

module "alb" {
  source = "./../../aws-terraform-alb"

  name               = var.name
  product            = var.product_name
  load_balancer_type = var.load_balancer_type
  internal           = var.internal
  vpc_id             = var.vpc_id
  subnets            = var.subnets
  security_groups    = module.sg.security_group_ids
  common_tags        = local.common_tags

  target_groups = [
    {
      name_prefix      = "tg00"
      backend_protocol = "HTTPS"
      backend_port     = 443
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = "i-XXXX"
          port      = 80
        }
      }
    },

    {
      name_prefix      = "tg01"
      backend_protocol = "HTTPS"
      backend_port     = 443
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = "i-XXXX"
          port      = 80
        }
      }
    }
  ]

  https_listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = "arn:aws:acm:us-east-1:375672701339:certificate/95b96b2d-45a4-48e0-8fde-b34c7b5c4e74"

      target_group_index = 0
    }
  ]


# target_groups = var.target_groups
# https_listeners = var.https_listeners
 https_listener_rules = var.https_listener_rules

  ###### Listener PRODUCAO ##########
#   https_listener_rules = [
#     {
#       https_listener_index = 0
#       priority             = 5000

#       actions = [{
#         type               = "forward"
#         target_group_index = 1
#       }]

#       conditions = [{
#         path_patterns = ["producao.XXXX.com.br"]
#       }]

#     },
#     ###### Listener TESTE #####
#     {
#       https_listener_index = 0
#       priority             = 3000
#       actions = [{
#         type               = "forward"
#         target_group_index = 0
#       }]
#       conditions = [{
#         path_patterns = ["teste.XXXX.com.br/*"]
#       }]
#     },

#     ############# Listener PJ ############
#     {
#       https_listener_index = 0
#       priority             = 4000
#       actions = [{
#         type               = "forward"
#         target_group_index = 0
#       }]
#       conditions = [{
#         path_patterns = ["pj.XXXX.com.br/*"]
#       }]
#     },
#   ]
}