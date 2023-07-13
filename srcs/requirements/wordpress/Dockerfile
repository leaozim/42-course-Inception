FROM alpine:3.17

ARG PHP_VERSION=81 

RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-phar \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    wget \
    mariadb-client

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && wp --info

RUN mkdir /run/php \
    && sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf \ 
    && touch /var/log/php${PHP_VERSION}-fpm.log
    
WORKDIR /var/www/

COPY ./requirements/wordpress/conf/wp-config-create.sh /var/www/

RUN wp core download --path=/var/www/ --allow-root \
    && chown -R nobody:nobody /run/php /var/log/php${PHP_VERSION}/ /var/www/

RUN chmod +x /var/www/wp-config-create.sh

USER nobody

ENTRYPOINT ["/bin/sh", "wp-config-create.sh"]

CMD ["/usr/sbin/php-fpm81", "--nodaemonize"]

