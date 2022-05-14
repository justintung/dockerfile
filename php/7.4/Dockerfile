FROM php:7.4-fpm
RUN usermod -u 1000 www-data

RUN rm -f /etc/localtime \
&& ln -sv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone

RUN apt-get update && apt-get install -y \
        git tree vim \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libgmp-dev \
        libmemcached-dev zlib1g-dev \
        libssl-dev \
        libmagickwand-dev libmagickcore-dev \
        libzip-dev zip
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd
RUN pecl install redis \
    && pecl install xdebug \
    && pecl install mongodb
RUN docker-php-ext-install pdo pdo_mysql bcmath gmp
RUN docker-php-ext-enable redis xdebug mongodb

RUN pecl install imagick \
	&& docker-php-ext-enable imagick
