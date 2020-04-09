FROM php:7.3.6-fpm-alpine3.9

WORKDIR /var/www


RUN docker-php-ext-install mysqli \
    pdo \
    pdo_mysql \
    pcntl \
    bcmath \
    gd \
    && docker-php-ext-enable pdo_mysql \
    bcmath

RUN apk add libzip-dev \
    && docker-php-ext-configure zip --with-libzip \
    && docker-php-ext-install zip \
    && docker-php-ext-enable zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Dockerize
RUN apk add --no-cache openssl
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz


EXPOSE 9000
