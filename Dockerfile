FROM nginx:alpine AS runtime
COPY index.html /usr/share/nginx/html/
# nginx:alpine already EXPOSEs 80; stock config listens on it.
CMD ["nginx", "-g", "daemon off;"]
