FROM php:7.2.4-fpm-alpine3.6

WORKDIR /var/www

MAINTAINER levonliu

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --update --no-cache \
    gettext tzdata icu-libs libpng libjpeg libcurl libintl libxml2 autoconf gcc g++ make \
    freetype ca-certificates > /dev/null

RUN apk add --no-cache --virtual .module-deps \
    icu-dev freetype-dev libjpeg-turbo-dev libmcrypt-dev libpng-dev \
    $PHPIZE_DEPS \
    zlib-dev curl-dev gettext-dev \
    libxml2-dev libressl-dev > /dev/null && \
    docker-php-ext-install gd intl pdo_mysql curl exif gettext xmlrpc bcmath opcache pcntl && \
    apk del .module-deps && \
    rm -fr /tmp/src && \
    rm -fr /var/cache/apk/*

#swoole
RUN curl -fsSL 'http://pecl.php.net/get/swoole-2.1.3.tgz' -o swoole.tgz \
    && mkdir -p swoole \
    && tar -xf swoole.tgz -C swoole --strip-components=1 \
    && rm swoole.tgz \
    && ( \
        cd swoole \
        && phpize \
        && ./configure --enable-swoole \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r swoole \
    && docker-php-ext-enable swoole

COPY ./run.sh /run.sh
RUN chmod +x /run.sh
CMD [ "/run.sh" ]