FROM php:7.2.5-zts-stretch

WORKDIR /var/www

MAINTAINER levonliu

RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak &&\
    echo "deb http://mirrors.aliyun.com/debian wheezy main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian wheezy main contrib non-free" >> /etc/apt/sources.list  && \
    echo "deb http://mirrors.aliyun.com/debian wheezy-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian wheezy-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian-security wheezy/updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian-security wheezy/updates main contrib non-free" >> /etc/apt/sources.list 


RUN apt-get update && apt-get install -y \
    zip    

RUN curl -fsSL 'https://codeload.github.com/krakjoe/pthreads/zip/master' -o pthreads.zip \
    && unzip pthreads.zip \
    && rm pthreads.zip \
    && ( \
        cd pthreads-master \
        && phpize \
        && ./configure --enable-pthreads \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r pthreads-master \
    && docker-php-ext-enable pthreads 