# Use the official image as a parent image.
FROM php:7.4-fpm

# Set the working directory.
WORKDIR /var/www

# Run the command inside your image filesystem.
RUN apt-get update
RUN apt-get install -qy --allow-unauthenticated \
    unzip \
    imagemagick \
    git \
    curl \
    libmcrypt-dev \
    zlib1g-dev \
    libzip-dev \
    zip unzip \
    libgmp-dev \
    libc-client-dev \
    libkrb5-dev \
	libmagickwand-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libjpeg-dev \
    libwebp-dev \
    libxpm-dev \
    libicu-dev \
    libxml2-dev \
    libssl-dev

RUN pecl install imagick

RUN docker-php-ext-configure gd --with-jpeg --with-freetype --with-webp

RUN docker-php-ext-install pdo_mysql gmp bcmath pcntl intl zip

RUN docker-php-ext-install opcache

RUN docker-php-ext-enable imagick

RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=32'; \
		echo 'opcache.max_accelerated_files=40000'; \
		echo 'opcache.revalidate_freq=5'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini


RUN docker-php-ext-install -j$(nproc) gd
