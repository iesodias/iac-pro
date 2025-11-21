variable "aws_region" {
  description = "Região da AWS onde os recursos serão criados"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente do lab (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "bucket_name" {
  description = "Nome do bucket S3 (deve ser globalmente único)"
  type        = string
}

variable "enable_versioning" {
  description = "Habilitar versionamento de objetos no bucket"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Permite destruir o bucket mesmo com objetos dentro (usar apenas em labs)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags adicionais para o bucket S3"
  type        = map(string)
  default = {
    Owner = "DevOps-Team"
  }
}
