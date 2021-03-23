FROM php:8.0.2-fpm
RUN usermod -u 1000 www-data

RUN rm -f /etc/localtime \
&& ln -sv /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "Asia/Shanghai" > /etc/timezone

RUN apt-get update && apt-get install -y \
        libssl-dev \
        libmagickwand-dev libmagickcore-dev
RUN pecl install redis \
    && pecl install xdebug \
    && pecl install mongodb
RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-enable redis xdebug mongodb

RUN pecl install imagick \
	&& docker-php-ext-enable imagick
