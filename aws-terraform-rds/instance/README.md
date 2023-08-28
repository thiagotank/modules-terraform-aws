# Módulo de RDS SQL Server (aws-terraform-rds)

O Módulo permite a criação e configuração do RDS SQL e Postgres personalizado. Esse módulo foi criado com o intuito de simplificar e agilizar o processo de gerenciamento.

# Uso
Para usar este módulo, adicione o seguinte código em seu arquivo Terraform:

```terraform

# Tags comum para o ambiente
  name          = "exempl-sql1"
  cia           = "BMM"
  ts            = "Observability"
  tracking_code = "SSD"
  product       = "Novo"

# Configurações específicas da instância RDS
  engine         = "sqlserver-se"
  engine_version = "15.00.4236.7.v1"
  instance_class = "db.m5.large"
  allocated_storage = 40
  max_allocated_storage = 100

# db_name  = "mysqlmodule"
  username = "exemplo"
  password = "Test12345"
  port     = 1433

  multi_az               = false # habilitar somente depois da criação do banco
  db_subnet_group_name   = "private"
  vpc_security_group_ids = ["sg-0a68ea12871318c09"]

# Janela de manutençao de atividades, backup e grupo de logs
  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["error"]
  create_cloudwatch_log_group     = true

# Ignorar a criação de um snapshot final ao excluir a instância e desativar/ativar a proteção contra exclusão acidental da instância RDS
  skip_final_snapshot = true
  deletion_protection = false

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60

```

# Variáveis
| Nome | Descrição	            | Tipo	| Padrão |
|------|------------------------|-------|-------------| 
| `name` | O nome do RDS |	string |Obrigatorio|
| `vpc_id`|	ID da VPC onde o Security Group será criado |string|Obrigatorio|
| `subnets`|Lista de IDs de subnets onde o RDS será implantado|list(string)|Obrigatorio|
|`product`|	Nome do produto irá definir tb as tags **aplication** e **description** associado ao Security Group |	string| sim|
|`internal`| Sem está variavel o padrão o criar ALB publico | `bool` |false|
|`common_tags`|	Tags comuns que serão aplicadas a todos os recursos.|map(string)|não|
`ingress_rules`|	Lista de regras de ingress personalizadas para o SG.|list(object)|não|

