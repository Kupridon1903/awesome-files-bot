FROM trafex/php-nginx:3.3.0

COPY ./ /app
COPY ./docker/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY ./docker/php/conf.d/settings.ini /etc/php82/conf.d/
COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=composer /usr/bin/composer /usr/bin/composer

USER root

RUN apk add --no-cache shadow \
  && usermod -u 1000 nobody \
  && groupmod -g 1000 nobody \
  && apk del shadow \
  && chown -R nobody.nobody /var/www/html /run /var/lib/nginx /var/log/nginx

WORKDIR /app

RUN apk add --no-cache \
  git \
  gcc \
  libcap \
  libc-dev \
  linux-headers \
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
    --no-cache \
    --no-interaction \
  && touch /var/log/xdebug.log \
  && chown nobody:nobody /var/log/xdebug.log \
  && chown -R nobody:nobody /app

COPY --chown=nobody ./docker/local/php/conf.d/*.ini /etc/php81/conf.d/

USER nobody
