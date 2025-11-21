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

variable "instance_name" {
  description = "Nome que identificará a instância EC2"
  type        = string
  default     = "lab-ec2"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.micro"
}

variable "allowed_ssh_cidr" {
  description = "CIDR liberado para acessar a instância via SSH"
  type        = string
  default     = "0.0.0.0/0"
}

variable "key_pair_name" {
  description = "Nome de um key pair existente na AWS (opcional)"
  type        = string
  default     = null
}

variable "root_volume_size" {
  description = "Tamanho do disco root em GB"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags adicionais aplicadas aos recursos"
  type        = map(string)
  default = {
    Owner = "DevOps-Team"
  }
}
