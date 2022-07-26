FROM php:fpm-alpine

LABEL MANTAINER=emanuel.dramos2@gmail.com

RUN apk add --no-cache --virtual .php-deps \
        make \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        zlib-dev \
        icu-dev \
        g++ \
        openldap-dev \
        libzip-dev \
        libjpeg-turbo-dev \
        libwebp-dev \
        freetype-dev \
    && docker-php-ext-configure intl \
    && apk add --no-cache \
        icu-libs \
        libzip \
        openldap-clients \
        libjpeg-turbo \
        libwebp \
        freetype \
    &&  docker-php-ext-configure gd --with-jpeg --with-webp --with-freetype \
    && docker-php-ext-install \
        intl gd mysqli exif ldap zip bz2 opcache \
    && { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } \
    && apk del .build-deps \
    && apk del .php-deps \
    && rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/*

COPY ./99-glpi.ini /etc/php81/conf.d/
