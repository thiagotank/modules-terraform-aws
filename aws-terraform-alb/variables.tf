variable "create_lb" {
  description = "Controla se o balanceador de carga deve ser criado"
  type        = bool
  default     = true
}

variable "drop_invalid_header_fields" {
  description = "Indica se campos de cabeçalho inválidos são descartados em balanceadores de carga de aplicativos. O padrão é falso."
  type        = bool
  default     = false
}

variable "preserve_host_header" {
  description = "Indica se o cabeçalho do host deve ser preservado e encaminhado aos destinos sem qualquer alteração. O padrão é falso."
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "Se true, a exclusão do balanceador de carga será desativada por meio da API da AWS. Isso impedirá que o Terraform exclua o balanceador de carga. O padrão é false."
  type        = bool
  default     = false
}

variable "enable_http2" {
  description = "Indica se o HTTP/2 está ativado em balanceadores de carga de aplicativos."
  type        = bool
  default     = true
}

variable "enable_cross_zone_load_balancing" {
  description = "Indica se o balanceamento de carga entre zonas deve ser ativado em balanceadores de carga de aplicativo."
  type        = bool
  default     = false
}

variable "enable_tls_version_and_cipher_suite_headers" {
  description = "Indica se os dois cabeçalhos (x-amzn-tls-version e x-amzn-tls-cipher-suite), que contêm informações sobre a versão TLS negociada e o conjunto de cifras, são adicionados à solicitação do cliente antes de enviá-la ao destino."
  type        = bool
  default     = false
}

variable "enable_xff_client_port" {
  description = "Indica se o cabeçalho X-Forwarded-For deve preservar a porta de origem que o cliente usou para se conectar ao balanceador de carga em balanceadores de carga de aplicativo."
  type        = bool
  default     = true
}

variable "extra_ssl_certs" {
  description = "Uma lista de mapas descrevendo quaisquer certificados SSL extras a serem aplicados aos ouvintes HTTPS. Chave/valores necessários: certificate_arn, https_listener_index (o índice do ouvinte em https_listeners ao qual o certificado se aplica)."
  type        = list(map(string))
  default     = []
}

variable "http_tcp_listeners" {
  description = "Uma lista de mapas que descrevem os listeners HTTP ou portas TCP para este ALB. Chave/valores necessários: porta, protocolo. Chave/valores opcionais: target_group_index (o padrão é http_tcp_listeners[count.index])"
  type        = any
  default     = []
}

variable "https_listener_rules" {
  description = "Uma lista de mapas que descrevem as Regras do Ouvinte para este ALB. Chave/valores necessários: ações, condições. Chave/valores opcionais: prioridade, https_listener_index (o padrão é https_listeners[count.index])"
  type        = any
  default     = []
}

variable "http_tcp_listener_rules" {
  description = "Uma lista de mapas que descrevem as Regras do Ouvinte para este ALB. Chave/valores necessários: ações, condições. Chave/valores opcionais: prioridade, http_tcp_listener_index (o padrão é http_tcp_listeners[count.index])"
  type        = any
  default     = []
}

variable "idle_timeout" {
  description = "O tempo em segundos que a conexão pode ficar ociosa."
  type        = number
  default     = 60
}

variable "ip_address_type" {
  description = "O tipo de endereços IP usados ​​pelas sub-redes para seu balanceador de carga. Os valores possíveis são ipv4 e dualstack."
  type        = string
  default     = "ipv4"
}

variable "listener_ssl_policy_default" {
  description = "A política de segurança se estiver usando HTTPS externamente no balanceador de carga."
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "internal" {
  description = "Booleano determinando se o balanceador de carga está voltado para dentro ou para fora."
  type        = bool
  default     = false
}

variable "load_balancer_create_timeout" {
  description = "Valor de tempo limite ao criar o ALB."
  type        = string
  default     = "10m"
}

variable "load_balancer_delete_timeout" {
  description = "Valor de tempo limite ao excluir o ALB."
  type        = string
  default     = "10m"
}

variable "name" {
  description = "O nome do recurso e a tag de nome do balanceador de carga."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "O prefixo do nome do recurso e a marca de nome do balanceador de carga. Não pode ter mais de 6 caractere"
  type        = string
  default     = null
}

variable "load_balancer_type" {
  description = "O tipo de balanceador de carga a ser criado. Os valores possíveis são aplicativo ou rede."
  type        = string
  default     = "application"
}

variable "load_balancer_update_timeout" {
  description = "Valor de tempo limite ao atualizar o ALB"
  type        = string
  default     = "10m"
}

variable "access_logs" {
  description = "Mapa contendo configuração de registro de acesso para balanceador de carga."
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "Uma lista de sub-redes para associar ao balanceador de carga"
  type        = list(string)
  default     = null
}

variable "subnet_mapping" {
  description = "Uma lista de blocos de mapeamento de sub-rede descrevendo sub-redes para anexar ao balanceador de carga de rede"
  type        = list(map(string))
  default     = []
}

variable "tags" {
  description = "Um mapa de tags para adicionar a todos os recursos"
  type        = map(string)
  default     = {}
}

variable "lb_tags" {
  description = "Um mapa de tags para adicionar ao balanceador de carga"
  type        = map(string)
  default     = {}
}

variable "target_group_tags" {
  description = "Um mapa de tags para adicionar a todos os grupos-alvo"
  type        = map(string)
  default     = {}
}

variable "https_listener_rules_tags" {
  description = "Um mapa de tags para adicionar a todas as regras de ouvinte https"
  type        = map(string)
  default     = {}
}

variable "http_tcp_listener_rules_tags" {
  description = "Um mapa de tags para adicionar a todas as regras do ouvinte http"
  type        = map(string)
  default     = {}
}

variable "https_listeners_tags" {
  description = "Um mapa de tags para adicionar a todos os ouvintes https"
  type        = map(string)
  default     = {}
}

variable "http_tcp_listeners_tags" {
  description = "Um mapa de tags para adicionar a todos os ouvintes https"
  type        = map(string)
  default     = {}
}

variable "security_groups" {
  description = "Os balanceadores de carga a serem anexados ao balanceador de carga. por exemplo. [\"sg-edcd9784\",\"sg-edcd9785\"]"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "ID da VPC em que o balanceador de carga e outros recursos serão implantados."
  type        = string
  default     = null
}

variable "enable_waf_fail_open" {
  description = "Indica se deve encaminhar solicitações para destinos se lb falhar ao encaminhar a solicitação para o AWS WAF"
  type        = bool
  default     = false
}

variable "desync_mitigation_mode" {
  description = "Determina como o balanceador de carga lida com solicitações que podem representar um risco de segurança para um aplicativo devido à dessincronização de HTTP."
  type        = string
  default     = "defensive"
}

variable "xff_header_processing_mode" {
  description = "Determina como o balanceador de carga modifica o cabeçalho X-Forwarded-For na solicitação HTTP antes de enviar a solicitação ao destino."
  type        = string
  default     = "append"
}

variable "cost_center" {
  description = "Determina a tag do centro de custo para o loadbalancer."
  type        = string
  default     = "CC-SSD"
}

variable "bs" {
  description = "Name tag for the load balancer."
  type        = string
  default     = "PGX_SUPERDIGITAL"
}

variable "product" {
  description = "Determina a tag do produto, description e aplication para o loadbalancer."
  type        = string
}

variable "common_tags" {
  description = "Tags comuns a serem aplicadas ao balanceador de carga."
  type        = map(string)
  default     = {}
}

variable "target_groups" {
  description = "List of target groups"
  type = list(object({
    name_prefix      = string
    backend_protocol = string
    backend_port     = number
    target_type      = string
    targets = map(object({
      target_id = string
      port      = number
    }))
  }))
}

variable "https_listeners" {
  description = "List of HTTPS listeners"
  type = list(object({
    port               = number
    protocol           = string
    certificate_arn    = string
    target_group_index = number
  }))
}