variable "meu_ip_publico" {
  type        = string
  description = "Seu IP público para liberar acesso SSH"
  # Consulte seu IP em: https://www.whatismyip.com/
  default     = "SEU_IP_AQUI/32"
}

variable "ec2_username" {
  type        = string
  description = "Usuário padrão para acesso SSH na instância EC2"
  default     = "ec2-user"
}

variable "ec2_key_name" {
  type        = string
  description = "Nome da chave SSH para acesso à instância EC2"
  default     = "ec2-key"
}