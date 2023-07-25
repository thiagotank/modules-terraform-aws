# Módulo de Securit Group (aws-terraform-sg)

O Módulo permite a criação e configuração de Security Groups com regras de ingress personalizadas. Esse módulo foi criado com o intuito de simplificar e agilizar o processo de gerenciamento.

# Uso
Para usar este módulo, adicione o seguinte código em seu arquivo Terraform:

```terraform
module "security_group" {
  source  = "./aws-terraform-sg/"
  name    = "Rendafixa"
  vpc_id  = "vpc-0e66de74"
  product = "monito"

  common_tags = {
    cia = "BMM"
    TS  = "Observability"
    tracking_code = "SSD"
  }

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
}
```

# Variáveis
| Nome | Descrição	            | Tipo	| Obrigatório |
|------|------------------------|-------|-------------| 
| `name` | Nome do Security Group |	string |	sim |
| `vpc_id`|	ID da VPC onde o Security Group será criado |string|	sim|
|`product`|	Nome do produto irá definir tb as tags **aplication** e **description** associado ao Security Group |	string| sim|
|`common_tags`|	Tags comuns que serão aplicadas a todos os recursos.|	map(string)|	não|
`ingress_rules`|	Lista de regras de ingress personalizadas para o SG.	|list(object)|	não|


