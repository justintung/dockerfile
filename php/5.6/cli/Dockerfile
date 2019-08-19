FROM php:5.6-cli
RUN apt-get update && apt-get install -y \
    libmemcached-dev \
    zlib1g-dev \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && pecl install memcached-2.2.0 \
    && docker-php-ext-enable memcached \
    && pecl install redis-2.2.8 \
    && docker-php-ext-enable redis \
    && pecl install xdebug-2.5.5 \
    && docker-php-ext-enable xdebug \
    && pecl install memcache-2.2.7 \
    && docker-php-ext-enable memcache
