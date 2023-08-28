variable "common_tags" {
  description = "Tags comuns a serem aplicadas ao RDS."
  type        = map(string)
  default     = {}
}

variable "create" {
  description = "Se deve criar este recurso ou não?"
  type        = bool
  default     = true
}

variable "identifier" {
  description = "O nome da instância RDS"
  type        = string
}
variable "custom_iam_instance_profile" {
  description = "Perfil de instância IAM personalizado do RDS"
  type        = string
  default     = null
}

variable "use_identifier_prefix" {
  description = "Determina se deve usar o identifier como está ou criar um identificador único começando com o identifier como prefixo especificado"
  type        = bool
  default     = false
}

variable "allocated_storage" {
  description = "O armazenamento alocado em gigabytes"
  type        = number
  default     = null
}

variable "storage_type" {
  description = "Um dos valores 'standard' (magnético), 'gp2' (SSD de propósito geral), 'gp3' (nova geração de SSD de propósito geral) ou 'io1' (SSD com IOPS provisionado). O padrão é 'io1' se iops for especificado, 'gp2' se não for. Se você especificar 'io1' ou 'gp3', também deve incluir um valor para o parâmetro 'iops"
  type        = string
  default     = null
}

variable "storage_throughput" {
  description = "Valor do rendimento de armazenamento para a instância do banco de dados. Essa configuração se aplica apenas ao tipo de armazenamento 'gp3'. Consulte as 'notas' para limitações em relação a essa variável para o tipo 'gp3'"
  type        = number
  default     = null
}

variable "storage_encrypted" {
  description = "Especifica se a instância do banco de dados está encriptada"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "O ARN para a chave de criptografia KMS. Se estiver criando uma réplica encriptada, defina isso como o ARN da KMS de destino. Se 'storage_encrypted' estiver definido como verdadeiro e 'kms_key_id' não for especificado, a chave KMS padrão criada na sua conta será usada"
  type        = string
  default     = null
}

variable "replicate_source_db" {
  description = "Especifica que este recurso é um banco de dados de réplica e que este valor deve ser usado como o banco de dados de origem. Isso está relacionado ao identificador de outro Banco de Dados Amazon RDS para replicação"
  type        = string
  default     = null
}

variable "license_model" {
  description = "Informações do modelo de licença para esta instância de banco de dados. Opcional, mas necessário para alguns mecanismos de banco de dados, por exemplo, o Oracle SE1"
  type        = string
  default     = null
}

variable "replica_mode" {
  description = "Especifica se a réplica está no modo montado ou somente leitura aberta. Esse atributo é suportado apenas por instâncias Oracle. Réplicas Oracle operam em modo somente leitura aberta, a menos que seja especificado de outra forma"
  type        = string
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = "Especifica se a autenticação de contas do AWS Identity and Access Management (IAM) ou mapeamentos para contas de banco de dados está habilitada"
  type        = bool
  default     = false
}

variable "domain" {
  description = "O ID do domínio de Diretório de Serviços do Active Directory para criar a instância"
  type        = string
  default     = null
}

variable "domain_iam_role_name" {
  description = "(Obrigatório se o domínio for fornecido) O nome da função IAM a ser usada ao fazer chamadas de API para o Diretório de Serviços"
  type        = string
  default     = null
}

variable "engine" {
  description = "O mecanismo de banco de dados a ser usado"
  type        = string
  default     = null
}

variable "engine_version" {
  description = "A versão do mecanismo a ser usada"
  type        = string
  default     = null
}

variable "instance_class" {
  description = "O tipo de instância da instância RDS"
  type        = string
  default     = null
}

variable "db_name" {
  description = "O nome do banco de dados a ser criado. Se omitido, nenhum banco de dados é criado inicialmente"
  type        = string
  default     = null
}

variable "username" {
  description = "Nome de usuário para o usuário principal do banco de dados"
  type        = string
  default     = null
}

variable "password" {
  description = "Senha para o usuário principal do banco de dados. Note que isso pode aparecer nos registros e será armazenado no arquivo de estado"
  type        = string
  default     = null
}

variable "manage_master_user_password" {
  description = "Defina como verdadeiro para permitir que o RDS gerencie a senha do usuário principal no Secrets Manager. Não pode ser definido se a senha for fornecida"
  type        = bool
  default     = false
}

variable "master_user_secret_kms_key_id" {
  description =  <<EOF
O ARN da chave, ID da chave, ARN do alias ou nome do alias para a chave KMS para criptografar o segredo da senha do usuário principal no Secrets Manager.
Se não for especificado, a chave KMS padrão para sua conta da Amazon Web Services será usada.
  EOF
  type        = string
  default     = null
}

variable "port" {
  description = "A porta na qual o banco de dados aceita conexões"
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Determina se um snapshot final do banco de dados é criado antes de a instância do banco de dados ser excluída. Se for especificado como verdadeiro, nenhum DBSnapshot será criado. Se for especificado como falso, um DBSnapshot é criado antes que a instância do banco de dados seja excluída"
  type        = bool
  default     = false
}

variable "snapshot_identifier" {
  description = "Especifica se deve criar ou não este banco de dados a partir de um snapshot. Isso se correlaciona com o ID do snapshot que você encontraria no console RDS, por exemplo: rds:producao-2015-06-26-06-05"
  type        = string
  default     = null
}

variable "copy_tags_to_snapshot" {
  description = "Na exclusão, copiar todas as tags da instância para o snapshot final"
  type        = bool
  default     = false
}

variable "final_snapshot_identifier_prefix" {
  description = "O nome que é prefixado ao snapshot final na destruição do cluster"
  type        = string
  default     = "final"
}

variable "vpc_security_group_ids" {
  description = "Lista de IDs de grupos de segurança VPC para associar"
  type        = list(string)
  default     = []
}

variable "db_subnet_group_name" {
  description = "Nome do grupo de sub-redes do banco de dados. A instância do banco de dados será criada na VPC associada ao grupo de sub-redes do banco de dados. Se não for especificado, será criado na VPC padrão"
  type        = string
  default     = null
}

variable "parameter_group_name" {
  description = "Nome do grupo de parâmetros do banco de dados para associar"
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "A Zona de Disponibilidade da instância RDS"
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Especifica se a instância RDS é de múltiplas Zonas de Disponibilidade"
  type        = bool
  default     = false
}

variable "iops" {
  description = "A quantidade de IOPS provisionados. Definir isso implica um tipo de armazenamento 'io1' ou gp3. Consulte as 'notas' para limitações em relação a essa variável para o tipo 'gp3"
  type        = number
  default     = null
}

variable "publicly_accessible" {
  description = "para controlar se a instância é acessível publicamente"
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "O intervalo, em segundos, entre pontos quando as métricas de Monitoramento Aprimorado são coletadas para a instância do banco de dados. Para desativar a coleta de métricas de Monitoramento Aprimorado, especifique 0. O padrão é 0. Valores válidos: 0, 1, 5, 10, 15, 30, 60"
  type        = number
  default     = 0
}

variable "monitoring_role_arn" {
  description = "O ARN para a função IAM que permite que o RDS envie métricas de monitoramento aprimorado para os Logs do CloudWatch. Deve ser especificado se 'monitoring_interval' for diferente de zero."
  type        = string
  default     = null
}

variable "monitoring_role_name" {
  description = "Nome da função IAM que será criada quando 'create_monitoring_role' estiver habilitado."
  type        = string
  default     = "rds-monitoring-role"
}

variable "monitoring_role_use_name_prefix" {
  description = "Determina se deve usar monitoring_role_name como está ou criar um identificador único começando com monitoring_role_name como o prefixo especificado"
  type        = bool
  default     = false
}

variable "monitoring_role_description" {
  description = "Descrição da função IAM de monitoramento"
  type        = string
  default     = null
}

variable "monitoring_role_permissions_boundary" {
  description = "ARN da política usada para definir o limite de permissões para a função IAM de monitoramento"
  type        = string
  default     = null
}

variable "create_monitoring_role" {
  description = "Criar função IAM com um nome definido que permite que o RDS envie métricas de monitoramento aprimorado para os Logs do CloudWatch."
  type        = bool
  default     = false
}

variable "allow_major_version_upgrade" {
  description = "Indica se as atualizações de versão principal são permitidas. Mudar esse parâmetro não resulta em uma interrupção e a alteração é aplicada de forma assíncrona o mais rápido possível"
  type        = bool
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indica se as atualizações de mecanismo menores serão aplicadas automaticamente à instância do banco de dados durante a janela de manutenção"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Especifica se as modificações no banco de dados são aplicadas imediatamente ou durante a próxima janela de manutenção"
  type        = bool
  default     = false
}

variable "maintenance_window" {
  description = "A janela para realizar a manutenção. Sintaxe: 'ddd:hh24:mi-ddd:hh24:mi'. Por exemplo: 'Seg:00:00-Seg:03:00"
  type        = string
  default     = null
}

variable "blue_green_update" {
  description = "Habilita atualizações de baixa interrupção usando implantações RDS Blue/Green"
  type        = map(string)
  default     = {}
}

variable "backup_retention_period" {
  description = "Os dias para reter backups"
  type        = number
  default     = null
}

variable "backup_window" {
  description = "O intervalo de tempo diário (em UTC) durante o qual os backups automáticos são criados se estiverem habilitados. Exemplo: '09:46"
  type        = string
  default     = null
}

variable "tags" {
  description = "Um mapeamento de tags para atribuir a todos os recursos"
  type        = map(string)
  default     = {}
}

variable "option_group_name" {
  description = "Nome do grupo de opções do banco de dados para associar.."
  type        = string
  default     = null
}

variable "timezone" {
  description = "Fuso horário da instância do banco de dados. timezone é atualmente suportado apenas pelo Microsoft SQL Server. O fuso horário só pode ser definido durante a criação. Consulte o Guia do Usuário do MSSQL para mais informações."
  type        = string
  default     = null
}

variable "character_set_name" {
  description = "O nome do conjunto de caracteres a ser usado para codificação de banco de dados em instâncias Oracle. Isso não pode ser alterado. Consulte os Conjuntos de Caracteres Oracle Suportados no Amazon RDS e Colações e Conjuntos de Caracteres para o Microsoft SQL Server para mais informações. Isso só pode ser definido durante a criação"
  type        = string
  default     = null
}

variable "nchar_character_set_name" {
  description = "O conjunto de caracteres nacional é usado nos tipos de dados NCHAR, NVARCHAR2 e NCLOB para instâncias Oracle. Isso não pode ser alterado."
  type        = string
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Lista de tipos de log para habilitar para exportação em logs do CloudWatch. Se omitido, nenhum log será exportado. Valores válidos (dependendo do mecanismo): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
  type        = list(string)
  default     = []
}

variable "timeouts" {
  description = "Tempos limite atualizados para gerenciamento de recursos do Terraform. Aplica-se particularmente a aws_db_instance para permitir tempos de gerenciamento de recursos"
  type        = map(string)
  default     = {}
}

variable "deletion_protection" {
  description = "O banco de dados não pode ser excluído quando esse valor é definido como true"
  type        = bool
  default     = false
}

variable "performance_insights_enabled" {
  description = "Especifica se o Performance Insights está habilitado"
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "A quantidade de tempo em dias para reter os dados do Performance Insights. Pode ser 7 (7 dias) ou 731 (2 anos)."
  type        = number
  default     = 7
}

variable "performance_insights_kms_key_id" {
  description = "O ARN para a chave KMS para criptografar os dados do Performance Insights.."
  type        = string
  default     = null
}

variable "max_allocated_storage" {
  description = "Especifica o valor para o Dimensionamento Automático de Armazenamento"
  type        = number
  default     = 0
}

variable "ca_cert_identifier" {
  description = "Especifica o identificador do certificado CA para a instância do banco de dados"
  type        = string
  default     = null
}

variable "delete_automated_backups" {
  description = "Especifica se os backups automáticos devem ser removidos imediatamente após a exclusão da instância do banco de dados"
  type        = bool
  default     = true
}

variable "s3_import" {
  description = "Restaurar a partir de um Percona Xtrabackup no S3 (somente MySQL é suportado)"
  type        = map(string)
  default     = null
}


variable "restore_to_point_in_time" {
  description = "Restaurar para um ponto no tempo (MySQL NÃO é suportado)"
  type        = map(string)
  default     = null
}

variable "network_type" {
  description = "O tipo de pilha de rede"
  type        = string
  default     = null
}


################################################################################
# CloudWatch Log Group
################################################################################

variable "create_cloudwatch_log_group" {
  description = "Determina se um grupo de log do CloudWatch é criado para cada enabled_cloudwatch_logs_exports"
  type        = bool
  default     = false
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "O número de dias para reter os logs do CloudWatch para a instância do banco de dados"
  type        = number
  default     = 7
}

variable "cloudwatch_log_group_kms_key_id" {
  description = "O ARN da Chave KMS a ser usada ao criptografar dados de log"
  type        = string
  default     = null
}

variable "cost_center" {
  description = "Determina a tag do centro de custo para o RDS."
  type        = string
  default     = "CC-SSD"
}

variable "bs" {
  description = "Tag de nome para o RDS."
  type        = string
  default     = "PGX_SUPERDIGITAL"
}

variable "product" {
  description = "Determina a tag do produto, description e aplication para o RDS."
  type        = string
}


