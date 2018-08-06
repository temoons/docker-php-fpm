FROM php:5.6-fpm-alpine3.4

WORKDIR /var/www

MAINTAINER levonliu

#替换源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories


RUN apk add --update --no-cache \
    gettext tzdata icu-libs libpng libjpeg libcurl libintl libxml2 m4 autoconf gcc g++ make libxml2-dev

RUN apk add --no-cache --virtual .module-deps \
    icu-dev freetype-dev libjpeg-turbo-dev libmcrypt-dev libpng-dev \
    $PHPIZE_DEPS \
    zlib-dev curl-dev gettext-dev && \
    docker-php-ext-install gd intl mysql mysqli mbstring pdo_mysql curl exif gettext xmlrpc bcmath opcache pcntl && \
    pecl install redis-3.1.3 \
    && docker-php-ext-enable redis \
    &&  rm -rf /tmp/pear \
    apk del .module-deps && \
    rm -fr /tmp/src && \
    rm -fr /var/cache/apk/*

#yar
RUN curl -fsSL 'http://pecl.php.net/get/yar-1.2.4.tgz' -o yar.tgz \
    && mkdir -p yar \
    && tar -xf yar.tgz -C yar --strip-components=1 \
    && rm yar.tgz \
    && ( \
        cd yar \
        && phpize \
        && ./configure --enable-yar \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r yar \
    && docker-php-ext-enable yar

#msgpack
RUN curl -fsSL 'http://pecl.php.net/get/msgpack-0.5.5.tgz' -o msgpack.tgz \
    && mkdir -p msgpack \
    && tar -xf msgpack.tgz -C msgpack --strip-components=1 \
    && rm msgpack.tgz \
    && ( \
        cd msgpack \
        && phpize \
        && ./configure --enable-msgpack \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r msgpack \
    && docker-php-ext-enable msgpack

COPY ./run.sh /run.sh
RUN chmod +x /run.sh
CMD [ "/run.sh" ]