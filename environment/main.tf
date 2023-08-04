locals {
  # Variáveis Comuns
  common_tags = {
    cia           = "BMM"
    TS            = "Observability"
    tracking_code = "SSD"
  }

  product_name = "monito"
  vpc_id       = "vpc-0721729cf29699773"
}

# Modulo security group
module "sg" {
  source = "./../aws-terraform-sg"

  name        = "Superdigital"
  vpc_id      = local.vpc_id
  product     = local.product_name
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
  source = "./../aws-terraform-alb"

  name               = "Superdigital"
  product            = local.product_name
  load_balancer_type = "application"
  internal           = "true"
  vpc_id             = local.vpc_id
  subnets            = ["subnet-0d7234146c0c0cd1c", "subnet-0470f8d42c1062dc0"]
  security_groups    = module.sg.security_group_ids
  common_tags        = local.common_tags

  target_groups = [
    {
      name_prefix      = "tg-01-"
      backend_protocol = "HTTPS"
      backend_port     = 443
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = "i-0222ae6aa7a442d4d"
          port      = 80
        }
      }
    },

    {
      name_prefix      = "tg-02-"
      backend_protocol = "HTTPS"
      backend_port     = 443
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = "i-0222ae6aa7a442d4d"
          port      = 80
        }
      }
    }
  ]

  https_listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = "arn:aws:acm:us-east-1:375672701339:certificate/14143223-f8f7-47d8-a41d-1e76772d3076"

      target_group_index = 0
    }
  ]

  ###### Listener PRODUCAO ##########
  https_listener_rules = [
    {
      https_listener_index = 0
      priority             = 5000

      actions = [{
        type               = "forward"
        target_group_index = 1
        # status_code = "HTTP_302"
        # host        = "www.youtube.com"
        # path        = "/watch"
        # query       = "v=dQw4w9WgXcQ"
        # protocol    = "HTTPS"
      }]

      conditions = [{
        path_patterns = ["producao.superdigital.com.br"]
      }]

    },
    ###### Listener TESTE #####
    {
      https_listener_index = 0
      priority             = 3000
      actions = [{
        type               = "forward"
        target_group_index = 0
      }]
      conditions = [{
        path_patterns = ["teste.superdigital.com.br/*"]
      }]
    },

    ############# Listener PJ ############
    {
      https_listener_index = 0
      priority             = 4000
      actions = [{
        type               = "forward"
        target_group_index = 0
      }]
      conditions = [{
        path_patterns = ["pj.superdigital.com.br/*"]
      }]
    },
  ]

  # http_tcp_listeners = [
  #   {
  #     port        = 80
  #     protocol    = "HTTP"
  #     action_type = "redirect"
  #     redirect = {
  #       port        = "443"
  #       protocol    = "HTTPS"
  #       status_code = "HTTP_301"
  #     }
  #   }
  # ]

  # tags = {
  #   Environment = "Test"
  # }
}