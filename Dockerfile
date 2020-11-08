# Use the official image as a parent image.
FROM php:7.4-fpm

# Set the working directory.
WORKDIR /var/www

# Run the command inside your image filesystem.
RUN apt-get update
RUN apt-get install -qy --allow-unauthenticated unzip git curl libmcrypt-dev zlib1g-dev libzip-dev zip unzip libgmp-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libjpeg-dev libwebp-dev libxpm-dev libicu-dev

RUN docker-php-ext-configure gd --with-jpeg --with-freetype --with-webp

RUN docker-php-ext-install pdo_mysql gmp bcmath pcntl intl zip

RUN docker-php-ext-install opcache

RUN docker-php-ext-install imagick

RUN echo 'opcache.enable_cli=1' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

RUN docker-php-ext-install -j$(nproc) gd
