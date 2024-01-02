FROM	debian:buster

RUN		apt-get update
RUN		apt-get install -y nginx \
                openssl

RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/ast-jean.crt \
       -keyout /etc/nginx/ssl/ast-jean.key \
       -subj "/C=CA/ST=QC/L=Quebec/O=42 School/OU=ast-jean/CN=ast-jean/"

COPY ./conf/nginx.conf /etc/nginx/conf.d

RUN mkdir -p /run/nginx

EXPOSE	443

CMD ["nginx", "-g", "daemon off;"]