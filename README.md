# 🚀 html-devops-lab

Projeto de portfólio demonstrando um pipeline DevOps completo: site estático em HTML containerizado com Docker, infraestrutura provisionada com Terraform na AWS e deploy automatizado via GitHub Actions.

---

## 📐 Arquitetura

```
┌─────────────┐     push      ┌──────────────────────┐
│   VS Code   │ ────────────► │   GitHub (main)       │
└─────────────┘               └──────────┬───────────┘
                                          │ GitHub Actions
                                          ▼
                               ┌──────────────────────┐
                               │  Build Docker Image  │
                               │  Push → Docker Hub   │
                               └──────────┬───────────┘
                                          │ SSH deploy
                                          ▼
                               ┌──────────────────────┐
                               │   AWS EC2 (t2.micro) │
                               │   Docker + Nginx     │
                               │   porta 80 → site    │
                               └──────────────────────┘
```

---

## 🗂️ Estrutura do Projeto

```
html-devops-lab/
├── src/
│   └── index.html               # Site estático
├── terraform/
│   ├── main.tf                  # Recursos AWS (EC2, SG, Key Pair)
│   ├── variables.tf             # Declaração de variáveis
│   ├── outputs.tf               # Outputs (IP, URL)
│   └── terraform.tfvars.example # Exemplo de configuração
├── .github/
│   └── workflows/
│       └── deploy.yml           # Pipeline CI/CD
├── Dockerfile                   # Imagem Nginx Alpine
├── docker-compose.yml           # Ambiente local
├── .gitignore
└── README.md
```

---

## 🛠️ Stack

| Camada       | Tecnologia              |
|--------------|-------------------------|
| Site         | HTML5 + CSS3            |
| Container    | Docker + Nginx Alpine   |
| IaC          | Terraform               |
| Cloud        | AWS EC2 (Free Tier)     |
| CI/CD        | GitHub Actions          |
| Registro     | Docker Hub              |

---

## ⚡ Como Rodar Localmente

**Pré-requisitos:** Docker instalado.

```bash
# 1. Clone o repositório
git clone https://github.com/ChayaElharek/html-devops-lab.git
cd html-devops-lab

# 2. Suba com Docker Compose
docker-compose up -d

# 3. Acesse no navegador
# http://localhost:8080
```

Para parar:
```bash
docker-compose down
```

---

## ☁️ Deploy na AWS com Terraform

### Pré-requisitos

- [Terraform](https://developer.hashicorp.com/terraform/install) instalado
- [AWS CLI](https://aws.amazon.com/cli/) configurado (`aws configure`)
- Par de chaves SSH (`~/.ssh/id_rsa.pub`)
- Conta no [Docker Hub](https://hub.docker.com)

### Passo a passo

```bash
# 1. Acesse a pasta do Terraform
cd terraform

# 2. Copie e preencha o arquivo de variáveis
cp terraform.tfvars.example terraform.tfvars
# Edite terraform.tfvars com seus dados

# 3. Inicialize o Terraform
terraform init

# 4. Visualize o plano
terraform plan

# 5. Aplique a infraestrutura
terraform apply

# O IP público será exibido ao final como output
```

Para destruir a infra (evitar cobranças):
```bash
terraform destroy
```

---

## 🔄 Pipeline CI/CD

O pipeline dispara automaticamente a cada `push` para a branch `main`.

### Etapas

1. **Build** — constrói a imagem Docker
2. **Push** — envia para o Docker Hub com tag `latest` e SHA do commit
3. **Deploy** — acessa a EC2 via SSH, para o container antigo e sobe o novo

### Secrets necessários no GitHub

Vá em **Settings → Secrets and variables → Actions** e adicione:

| Secret               | Descrição                           |
|----------------------|-------------------------------------|
| `DOCKERHUB_USERNAME` | Seu usuário do Docker Hub           |
| `DOCKERHUB_TOKEN`    | Token de acesso do Docker Hub       |
| `EC2_HOST`           | IP público da EC2                   |
| `EC2_SSH_KEY`        | Conteúdo da chave privada SSH (`.pem`) |

---

## 📸 Preview

Acesse o site em execução: `http://<EC2_IP>`

---

## 📚 Conceitos Aplicados

- **Containerização** com Docker e Nginx
- **Infraestrutura como Código** com Terraform
- **CI/CD** com GitHub Actions
- **Cloud computing** na AWS (EC2, Security Groups, Key Pairs)
- **GitOps** — infraestrutura e aplicação versionadas juntas

---

## 👩‍💻 Autora

**Chaya Elharek** — DevOps Engineer  
[github.com/ChayaElharek](https://github.com/ChayaElharek)

---

*Projeto desenvolvido para fins de portfólio e aprendizado de práticas DevOps.*
