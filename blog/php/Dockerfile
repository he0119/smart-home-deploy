FROM php:8.1.1-fpm-alpine

RUN sed -i 's#https://dl-cdn.alpinelinux.org#http://mirrors.tencentyun.com#g' /etc/apk/repositories

RUN set -ex && \
  apk --no-cache add postgresql-dev

RUN docker-php-ext-install pdo pdo_pgsql
