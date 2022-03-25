FROM php:7.3-fpm
RUN usermod -u 1000 www-data

RUN rm -f /etc/localtime \
&& ln -sv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libmemcached-dev zlib1g-dev \
        libssl-dev \
        libmagickwand-dev libmagickcore-dev \
        libzip-dev zip \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd
RUN pecl install redis \
    && pecl install xdebug \
    && pecl install imagick \
    && pecl install mongodb
RUN docker-php-ext-install pdo pdo_mysql mysqli zip bcmath pcntl
RUN docker-php-ext-enable redis xdebug mongodb imagick

