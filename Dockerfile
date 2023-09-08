FROM trafex/php-nginx:3.3.0

COPY ./ /app
COPY ./docker/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/php/conf.d/*.ini /etc/php82/conf.d/
COPY --from=composer /usr/bin/composer /usr/bin/composer

USER root

WORKDIR /app

RUN apk add --no-cache \
  git \
  gcc \
  libcap \
  libc-dev \
  make \
  php82-dev \
  php82-fileinfo \
  php82-iconv \
  php82-pear \
  php82-pdo \
  php82-pdo_pgsql \
  php82-pgsql \
  php82-simplexml \
  php82-sodium \
  php82-tokenizer \
  php82-xmlwriter \
  php82-pecl-xdebug \
  && composer install \
    --no-dev \
    --no-cache \
    --no-interaction \
  && chown -R nobody:nobody /app

EXPOSE 8080

USER nobody
