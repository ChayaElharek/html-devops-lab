# ──────────────────────────────────────────────
# html-devops-lab · Dockerfile
# Serve o site estático usando Nginx Alpine
# ──────────────────────────────────────────────

FROM nginx:1.25-alpine

# Remove a página padrão do Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia o site para dentro do container
COPY src/ /usr/share/nginx/html/

# Expõe a porta 80
EXPOSE 80

# Nginx sobe automaticamente com o CMD padrão da imagem
