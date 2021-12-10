FROM alpine:3.15
RUN apk update && apk add --no-cache apache2
COPY index.html /var/www/localhost/htdocs/
EXPOSE 80
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]