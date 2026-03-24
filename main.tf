# ──────────────────────────────────────────────
# html-devops-lab · Terraform
# Provisiona EC2 na AWS para rodar o container
# ──────────────────────────────────────────────

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# ── Security Group ──────────────────────────────
resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-sg"
  description = "Permite HTTP e SSH"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # Em produção, restrinja ao seu IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-sg"
    Project = var.project_name
  }
}

# ── Key Pair ────────────────────────────────────
resource "aws_key_pair" "deployer" {
  key_name   = "${var.project_name}-key"
  public_key = file(var.public_key_path)
}

# ── EC2 Instance ────────────────────────────────
resource "aws_instance" "web" {
  ami                    = var.ami_id          # Amazon Linux 2023
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Instala Docker e sobe o container no boot
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker
    systemctl start docker
    systemctl enable docker
    usermod -aG docker ec2-user

    # Puxa e sobe a imagem do Docker Hub
    docker pull ${var.docker_image}
    docker run -d --name html-devops-lab -p 80:80 --restart unless-stopped ${var.docker_image}
  EOF

  tags = {
    Name    = "${var.project_name}-server"
    Project = var.project_name
  }
}
