FROM php:5.6-fpm
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
    && docker-php-ext-install -j$(nproc) iconv mcrypt pdo pdo_mysql bcmath mysqli\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
RUN pecl install redis-2.2.8 \
    && docker-php-ext-enable redis
RUN pecl install memcached-2.2.0 \
	&& pecl install memcache-2.2.7 \
    && docker-php-ext-enable memcached memcache
RUN pecl install mongo-1.6.16 \
	&& pecl install mongodb-1.7.4 \
    && docker-php-ext-enable mongo mongodb
RUN pecl install imagick \
	&& docker-php-ext-enable imagick

