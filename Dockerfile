FROM nginx:alpine AS runtime
# Site URL baked into canonical / og:url / JSON-LD at build time.
# Override via compose build args or an .env file next to docker-compose.yml.
ARG SITE_URL=https://json-merge.online/
COPY index.html /usr/share/nginx/html/
RUN sed -i "s|__SITE_URL__|${SITE_URL}|g" /usr/share/nginx/html/index.html
# nginx:alpine already EXPOSEs 80; stock config listens on it.
CMD ["nginx", "-g", "daemon off;"]
