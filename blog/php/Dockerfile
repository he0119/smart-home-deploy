FROM php:7.4.12-fpm-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tencentyun.com/g' /etc/apk/repositories

RUN set -ex && \
  apk --no-cache add postgresql-dev

RUN docker-php-ext-install pdo pdo_pgsql
