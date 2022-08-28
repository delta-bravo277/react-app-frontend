FROM nginx:latest
COPY build /usr/share/nginx/html
EXPOSE 6060
CMD ["/bin/sh", "-c", "sed -i 's/listen  .*/listen 6060;/g' /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"]