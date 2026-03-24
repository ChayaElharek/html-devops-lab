# ──────────────────────────────────────────────
# html-devops-lab · Variáveis Terraform
# ──────────────────────────────────────────────

variable "aws_region" {
  description = "Região AWS onde a instância será criada"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nome do projeto (usado nos recursos)"
  type        = string
  default     = "html-devops-lab"
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"   # Free Tier elegível
}

variable "ami_id" {
  description = "AMI Amazon Linux 2023 (us-east-1)"
  type        = string
  default     = "ami-0c101f26f147fa7fd"
}

variable "public_key_path" {
  description = "Caminho da chave SSH pública"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "docker_image" {
  description = "Imagem Docker Hub a ser usada (usuario/repo:tag)"
  type        = string
  default     = "seuusuario/html-devops-lab:latest"
}
