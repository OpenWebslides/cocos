FROM php:7.3-fpm

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libzip-dev \
        libpng-dev \
        libicu-dev \
        libxml2-dev \
        g++ \
        wget unzip \
        libxml2-utils \
        libxslt1.1 libxslt1-dev

RUN pecl install mcrypt-1.0.2 && docker-php-ext-enable mcrypt

RUN docker-php-ext-install -j$(nproc) iconv xsl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd exif mysqli pdo_mysql zip intl xmlrpc soap

RUN docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache

RUN usermod -u 1000 www-data

COPY opcache.ini $PHP_INI_DIR/conf.d/
COPY max_filesize.ini $PHP_INI_DIR/conf.d/

# Install KindleGen
RUN wget http://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz -O /tmp/kindlegen.tar.gz
RUN tar xzf /tmp/kindlegen.tar.gz -C /tmp
RUN mv /tmp/kindlegen /usr/local/bin
RUN rm -r /tmp/*

# Install epubcheck
RUN mkdir -p /usr/share/man/man1 && apt-get update && apt-get install -y openjdk-8-jre
RUN wget https://github.com/w3c/epubcheck/releases/download/v4.1.1/epubcheck-4.1.1.zip -O /tmp/epubcheck.zip
RUN unzip /tmp/epubcheck.zip -d /tmp
RUN mkdir -p /usr/local/share/java/
RUN cp -r /tmp/epubcheck-4.1.1/* /usr/local/share/java/
RUN rm -r /tmp/*

# Install Saxon HE
RUN wget http://central.maven.org/maven2/net/sf/saxon/Saxon-HE/9.9.1-2/Saxon-HE-9.9.1-2.jar -O /usr/local/share/java/Saxon-HE.jar
