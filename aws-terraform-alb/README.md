# Módulo AWS Application Load Balancer (ALB)

Este módulo Terraform implanta um AWS Application Load Balancer (ALB) juntamente com grupos de destino e listeners associados. Ele fornece uma maneira fácil de criar recursos ALB com configurações específicas. Os valores para consumir o modulo de security podem ser necessarios e serão fornecidos um exemplo de criação de regras de entrada

# Pré-requisitos
Versão do Terraform >= 0.12.x

# Uso
Para usar este módulo, adicione o seguinte código em seu arquivo Terraform:

```terraform
locals {
  # Variáveis Comuns
  common_tags = {
    cia           = "BMM"
    TS            = "Observability"
    tracking_code = "SSD"
  }

  product_name = "monito"
  vpc_id       = "vpc-XXXXXX"
  subnets      =  ["subnet-XXXXX", "subnet-XXXXXX"]
}

module "alb" {
  source = "./../aws-terraform-alb"

  # Entradas Obrigatórias
  name               = "XXXXX"                      # O nome do Application Load Balancer (ALB)
  product            = local.product_name           # A tag do nome do produto para recursos do ALB
  load_balancer_type = "application"                # O tipo de load balancer (por exemplo, application, network)
  internal           = "true"                       # Sinalizador booleano para especificar se o ALB é interno
  vpc_id             = local.vpc_id                 # O ID do VPC onde o ALB será criado
  subnets            = local.subnets                # Lista de IDs de subnets onde o ALB será implantado
  security_groups    = module.sg.security_group_ids  # Lista de IDs de grupos de segurança para o ALB (Module SG)
  common_tags        = local.common_tags            # Mapa de tags comuns a serem aplicadas ao ALB

  # Grupos de Destino
  target_groups = [
    {
      name_prefix      = "tg-01-"
      backend_protocol = "HTTPS"
      backend_port     = 443
      target_type      = "instance"
      targets = {
        my_target = {
          target_id = "i-XXXXX"
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
          target_id = "i-XXXXX"
          port      = 80
        }
      }
    }
  ]

  # Listeners HTTPS
  https_listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = "arn:aws:acm:XXXXXX"
      target_group_index = 0
    }
  ]

  # Regras do Listener HTTPS
  https_listener_rules = [
    {
      https_listener_index = 0
      priority             = 5000

      actions = [{
        type               = "forward"
        target_group_index = 1
      }]

      conditions = [{
        path_patterns = ["XXXXX.superdigital.com.br"]
      }]
    },
    {
      https_listener_index = 0
      priority             = 3000
      actions = [{
        type               = "forward"
        target_group_index = 0
      }]
      conditions = [{
        path_patterns = ["XXXXX.superdigital.com.br/*"]
      }]
    },
    {
      https_listener_index = 0
      priority             = 4000
      actions = [{
        type               = "forward"
        target_group_index = 0
      }]
      conditions = [{
        path_patterns = ["XXXXXX.superdigital.com.br/*"]
      }]
    },
  ]
}

```

# Variáveis
| Nome | Descrição	            | Tipo	| Padrão |
|------|------------------------|-------|-------------| 
| `name` | O nome do Application Load Balancer (ALB) |	string |Obrigatorio|
| `vpc_id`|	ID da VPC onde o Security Group será criado |string|Obrigatorio|
| `subnets`|Lista de IDs de subnets onde o ALB será implantado|list(string)|Obrigatorio|
|`product`|	Nome do produto irá definir tb as tags **aplication** e **description** associado ao Security Group |	string| sim|
|`internal`| Sem está variavel o padrão o criar ALB publico | `bool` |false|
|`common_tags`|	Tags comuns que serão aplicadas a todos os recursos.|map(string)|não|
`ingress_rules`|	Lista de regras de ingress personalizadas para o SG.|list(object)|não|


