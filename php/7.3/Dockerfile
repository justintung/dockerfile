FROM php:7.3-fpm
RUN apt-get update
RUN pecl install redis \
    && pecl install xdebug \
    && pecl install mongodb
RUN docker-php-ext-enable redis xdebug mongodb
