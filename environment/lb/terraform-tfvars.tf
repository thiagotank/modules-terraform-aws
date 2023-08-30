## Variaveis comuns ##
name          = "projeto-fenix" # Nome do recurso
product       = "pejotao"
cia           = "BMM"
ts            = "Observability"
tracking_code = "SSD"

## Network ##
vpc_id  = "vpc-0721729cf29699773"
subnets = ["subnet-0470f8d42c1062dc0", "subnet-0c1614d14ad3063d7"]

## Valores Aplication Loadbalancer ##
load_balancer_type = "application"
internal           = "true"
product_name       = "monitor"

###### Listener PRODUCAO ##########
https_listener_rules = [
  {
    https_listener_index = 0
    priority             = 5000

    actions = [{
      type               = "forward"
      target_group_index = 1
    }]

    conditions = [{
      path_patterns = ["producao.XXXX.com.br"]
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
      path_patterns = ["teste.XXXX.com.br/*"]
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
      path_patterns = ["pj.XXXX.com.br/*"]
    }]
  },
]

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


## Valore para regras de entrada no grupo de segurança ##
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
