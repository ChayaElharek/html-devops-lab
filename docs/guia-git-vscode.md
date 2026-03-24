# 📋 Guia: Do VS Code ao GitHub — Passo a Passo

Este guia explica como subir o projeto `html-devops-lab` no GitHub usando o VS Code.

---

## PARTE 1 — Preparação (faça uma vez só)

### 1.1 Instalar Git

Verifique se já tem instalado:
```bash
git --version
```

Se não tiver: baixe em https://git-scm.com/download/win (Windows) ou:
```bash
# Ubuntu/Debian
sudo apt install git -y
```

### 1.2 Configurar sua identidade no Git

```bash
git config --global user.name "Chaya Elharek"
git config --global user.email "seu@email.com"
```

Isso aparece nos seus commits. Faça uma vez e vale para todos os projetos.

### 1.3 Criar conta no GitHub

Se ainda não tiver: https://github.com/signup

---

## PARTE 2 — Criar o repositório no GitHub

1. Acesse https://github.com/new
2. Preencha:
   - **Repository name:** `html-devops-lab`
   - **Description:** `Pipeline DevOps completo: Docker + Terraform + AWS + GitHub Actions`
   - Marque **Public** (portfólio precisa ser público)
   - **NÃO marque** "Add a README file" (já temos um)
3. Clique em **Create repository**
4. Guarde a URL que aparece, tipo: `https://github.com/ChayaElharek/html-devops-lab.git`

---

## PARTE 3 — Subir o projeto pelo VS Code

### Opção A: Pelo Terminal integrado do VS Code (recomendado)

Abra o terminal no VS Code com `Ctrl + '` (acento grave) ou menu **Terminal → New Terminal**.

```bash
# 1. Entre na pasta do projeto
cd caminho/para/html-devops-lab
# Exemplo: cd C:\projetos\html-devops-lab (Windows)
# Exemplo: cd ~/projetos/html-devops-lab  (Linux/Mac)

# 2. Inicialize o repositório Git local
git init

# 3. Adicione todos os arquivos à área de staging
git add .

# 4. Faça o primeiro commit
git commit -m "feat: estrutura inicial do projeto html-devops-lab"

# 5. Renomeie a branch para 'main' (padrão atual do GitHub)
git branch -M main

# 6. Conecte ao repositório remoto do GitHub
#    Substitua pela sua URL!
git remote add origin https://github.com/ChayaElharek/html-devops-lab.git

# 7. Envie o código para o GitHub
git push -u origin main
```

Na primeira vez, o VS Code/Git vai pedir autenticação com o GitHub.
Use seu usuário e um **Personal Access Token** (não senha — veja como criar abaixo).

### Opção B: Pela interface gráfica do VS Code

1. Clique no ícone de **Source Control** na barra lateral (ou `Ctrl+Shift+G`)
2. Clique em **Initialize Repository**
3. Na caixa de mensagem, escreva: `feat: estrutura inicial do projeto html-devops-lab`
4. Clique no botão **Commit** (ícone de ✓)
5. Clique em **Publish Branch**
6. Escolha o GitHub e dê o nome `html-devops-lab`

---

## PARTE 4 — Criar Personal Access Token (autenticação)

O GitHub não aceita senha normal para push. Use um token:

1. GitHub → clique na sua foto → **Settings**
2. No menu esquerdo, role até **Developer settings**
3. **Personal access tokens → Tokens (classic)**
4. Clique em **Generate new token (classic)**
5. Preencha:
   - Note: `html-devops-lab`
   - Expiration: 90 days (ou sem expiração para estudo)
   - Marque: **repo** (acesso completo)
6. Clique **Generate token**
7. **COPIE O TOKEN AGORA** — ele não aparece de novo!

Quando o Git pedir senha, cole o token.

---

## PARTE 5 — Configurar Secrets no GitHub (para o CI/CD funcionar)

1. No repositório, vá em **Settings → Secrets and variables → Actions**
2. Clique em **New repository secret** e adicione um por um:

| Nome                 | Valor                                    |
|----------------------|------------------------------------------|
| `DOCKERHUB_USERNAME` | seu usuário no Docker Hub                |
| `DOCKERHUB_TOKEN`    | token criado no Docker Hub               |
| `EC2_HOST`           | IP da EC2 (depois do terraform apply)    |
| `EC2_SSH_KEY`        | conteúdo do arquivo .pem da chave SSH    |

Para `EC2_SSH_KEY`, abra o arquivo `.pem` em um editor de texto e copie **tudo**, incluindo as linhas `-----BEGIN RSA PRIVATE KEY-----`.

---

## PARTE 6 — Fluxo de trabalho diário (após tudo configurado)

Sempre que fizer alterações:

```bash
# Ver o que mudou
git status

# Adicionar arquivos modificados
git add .

# Fazer commit com mensagem descritiva
git commit -m "fix: atualiza texto do site"

# Enviar para o GitHub (dispara o CI/CD automaticamente!)
git push
```

### Boas práticas de mensagens de commit

Use o padrão **Conventional Commits**:

| Prefixo    | Quando usar                          |
|------------|--------------------------------------|
| `feat:`    | Nova funcionalidade                  |
| `fix:`     | Correção de bug                      |
| `docs:`    | Mudança em documentação              |
| `chore:`   | Ajuste de configuração/infra         |
| `refactor:`| Refatoração sem mudança de comportamento |

Exemplos:
```
feat: adiciona página de contato
fix: corrige porta no docker-compose
docs: atualiza instruções do README
chore: ajusta variáveis do Terraform
```

---

## PARTE 7 — Verificar se o pipeline rodou

1. No GitHub, clique na aba **Actions**
2. Você verá o workflow **CI/CD Pipeline** rodando
3. Clique nele para ver os logs em tempo real
4. Verde ✅ = sucesso | Vermelho ❌ = erro (clique para ver o log)

---

## Resumo visual do fluxo

```
VS Code  →  git add .  →  git commit  →  git push
                                              │
                                    GitHub Actions dispara
                                              │
                                    Build Docker Image
                                              │
                                    Push → Docker Hub
                                              │
                                    Deploy na EC2 via SSH
                                              │
                                    Site no ar! 🎉
```
