FROM php:7.0-fpm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libicu-dev \
        libxml2-dev \
        g++

RUN docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd exif mysqli pdo_mysql zip intl xmlrpc soap

RUN docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache
    
COPY opcache.ini $PHP_INI_DIR/conf.d/
COPY max_filesize.ini $PHP_INI_DIR/conf.d/
