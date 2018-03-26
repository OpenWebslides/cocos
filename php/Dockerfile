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

RUN usermod -u 1000 www-data

COPY opcache.ini $PHP_INI_DIR/conf.d/
COPY max_filesize.ini $PHP_INI_DIR/conf.d/

# Install KindleGen
RUN apt-get update && apt-get install -y wget
RUN wget http://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz -O /tmp/kindlegen.tar.gz
RUN tar xzf /tmp/kindlegen.tar.gz -C /tmp
RUN mv /tmp/kindlegen /usr/local/bin
RUN rm -r /tmp/*
