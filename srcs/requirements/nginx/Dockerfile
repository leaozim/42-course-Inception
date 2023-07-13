FROM alpine:3.17

ARG DOMAIN_NAME

RUN apk update && apk upgrade && apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl

WORKDIR /etc/nginx/ssl

RUN wget -O mkcert https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 && \
    chmod +x mkcert && \
    mv mkcert /usr/local/bin/

RUN mkcert -key-file ${DOMAIN_NAME}.key -cert-file ${DOMAIN_NAME}.crt ${DOMAIN_NAME}

WORKDIR /

EXPOSE 443

COPY ./requirements/nginx/conf/ /etc/nginx/http.d/

CMD ["nginx", "-g", "daemon off;"]
