ARG PHP_VERSION

FROM php:${PHP_VERSION}-alpine

# Download script to install PHP extensions and dependencies
ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync

# Install necessary packages for building the extension
RUN apk --no-cache add git autoconf g++ make

RUN mkdir /app
COPY extension /app/extension

# Build and install xhprof extension
RUN cd /app/extension \
    && phpize \
    && ./configure --with-php-config=/usr/local/bin/php-config \
    && make \
    && make install

# Clean up to reduce image size
RUN rm -rf /usr/src/xhprof \
    && apk del git autoconf g++

# Enable the xhprof extension in php.ini
RUN echo "[xhprof]" > /usr/local/etc/php/conf.d/xhprof.ini \
    && echo "extension = xhprof.so" >> /usr/local/etc/php/conf.d/xhprof.ini \
    && echo "xhprof.output_dir = /tmp/xhprof" >> /usr/local/etc/php/conf.d/xhprof.ini

# Install bash
RUN apk add --no-cache bash

# Test build
COPY scripts/test.sh /app
RUN bash /app/test.sh

WORKDIR /app/extension
