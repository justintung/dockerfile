FROM php:7.4-fpm
RUN usermod -u 1000 www-data
RUN apt-get update
RUN pecl install redis \
    && pecl install xdebug \
    && pecl install mongodb
RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-enable redis xdebug mongodb
