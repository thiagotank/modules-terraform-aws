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

variable "https_listeners" {
  description = "Uma lista de mapas que descrevem os listeners HTTPS para este ALB. Chave/valores necessários: porta, certificate_arn. Chave/valores opcionais: ssl_policy (o padrão é ELBSecurityPolicy-2016-08), target_group_index (o padrão é https_listeners[count.index])"
  type        = any
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
  description = "The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack."
  type        = string
  default     = "ipv4"
}

variable "listener_ssl_policy_default" {
  description = "The security policy if using HTTPS externally on the load balancer. [See](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-policy-table.html)."
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
}

variable "internal" {
  description = "Boolean determining if the load balancer is internal or externally facing."
  type        = bool
  default     = false
}

variable "load_balancer_create_timeout" {
  description = "Timeout value when creating the ALB."
  type        = string
  default     = "10m"
}

variable "load_balancer_delete_timeout" {
  description = "Timeout value when deleting the ALB."
  type        = string
  default     = "10m"
}

variable "name" {
  description = "The resource name and Name tag of the load balancer."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "The resource name prefix and Name tag of the load balancer. Cannot be longer than 6 characters"
  type        = string
  default     = null
}

variable "load_balancer_type" {
  description = "The type of load balancer to create. Possible values are application or network."
  type        = string
  default     = "application"
}

variable "load_balancer_update_timeout" {
  description = "Timeout value when updating the ALB."
  type        = string
  default     = "10m"
}

variable "access_logs" {
  description = "Map containing access logging configuration for load balancer."
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "A list of subnets to associate with the load balancer. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']"
  type        = list(string)
  default     = null
}

variable "subnet_mapping" {
  description = "A list of subnet mapping blocks describing subnets to attach to network load balancer"
  type        = list(map(string))
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "lb_tags" {
  description = "A map of tags to add to load balancer"
  type        = map(string)
  default     = {}
}

variable "target_group_tags" {
  description = "A map of tags to add to all target groups"
  type        = map(string)
  default     = {}
}

variable "https_listener_rules_tags" {
  description = "A map of tags to add to all https listener rules"
  type        = map(string)
  default     = {}
}

variable "http_tcp_listener_rules_tags" {
  description = "A map of tags to add to all http listener rules"
  type        = map(string)
  default     = {}
}

variable "https_listeners_tags" {
  description = "A map of tags to add to all https listeners"
  type        = map(string)
  default     = {}
}

variable "http_tcp_listeners_tags" {
  description = "A map of tags to add to all http listeners"
  type        = map(string)
  default     = {}
}

variable "security_groups" {
  description = "The load balancers to attach to the load balancer. e.g. [\"sg-edcd9784\",\"sg-edcd9785\"]"
  type        = list(string)
  default     = []
}

variable "target_groups" {
  description = "A list of maps containing key/value pairs that define the target groups to be created. Order of these maps is important and the index of these are to be referenced in listener definitions. Required key/values: name, backend_protocol, backend_port"
  type        = any
  default     = []
}

variable "vpc_id" {
  description = "VPC id where the load balancer and other resources will be deployed."
  type        = string
  default     = null
}

variable "enable_waf_fail_open" {
  description = "Indicates whether to route requests to targets if lb fails to forward the request to AWS WAF"
  type        = bool
  default     = false
}

variable "desync_mitigation_mode" {
  description = "Determines how the load balancer handles requests that might pose a security risk to an application due to HTTP desync."
  type        = string
  default     = "defensive"
}

variable "xff_header_processing_mode" {
  description = "Determines how the load balancer modifies the X-Forwarded-For header in the HTTP request before sending the request to the target."
  type        = string
  default     = "append"
}


################################################################################
# load balancer
################################################################################

# variable "create_security_group" {
#   description = "Determines if a load balancer is created"
#   type        = bool
#   default     = true
# }

# variable "security_group_name" {
#   description = "Name to use on load balancer created"
#   type        = string
#   default     = null
# }

# variable "security_group_use_name_prefix" {
#   description = "Determines whether the load balancer name (`security_group_name`) is used as a prefix"
#   type        = bool
#   default     = true
# }

# variable "security_group_description" {
#   description = "Description of the load balancer created"
#   type        = string
#   default     = null
# }

# variable "security_group_rules" {
#   description = "load balancer rules to add to the load balancer created"
#   type        = any
#   default     = {}
# }

# variable "security_group_tags" {
#   description = "A map of additional tags to add to the load balancer created"
#   type        = map(string)
#   default     = {}
# }

# variable "web_acl_arn" {
#   description = "WAF ARN to associate this LB with."
#   type        = string
#   default     = null
# }

variable "cost_center" {
  description = "Name tag for the load balancer."
  type        = string
  default     = "CC-SSD"
}

variable "bs" {
  description = "Name tag for the load balancer."
  type        = string
  default     = "PGX_SUPERDIGITAL"
}

variable "product" {
  description = "Name tag for the load balancer."
  type        = string
}

variable "common_tags" {
  description = "Common tags to be applied to the load balancer."
  type        = map(string)
  default     = {}
}