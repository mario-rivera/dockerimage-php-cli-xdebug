FROM php:7.4-cli

ENV WORKDIR /code

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
libzip-dev \
libssl-dev \
zip \
unzip \
libpq-dev \
librabbitmq-dev \
libgmp-dev \
git \
&& rm -rf /var/lib/apt/lists/*

# install php extensions
RUN docker-php-ext-configure zip \
&& docker-php-ext-configure pdo_pgsql \
&& docker-php-ext-configure gmp \
&& docker-php-ext-install \
zip pdo pdo_pgsql bcmath sockets gmp \
&& pecl install xdebug-2.9.8 amqp-1.9.4 \
&& docker-php-ext-enable xdebug amqp

# install composer
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer --version=2.0.8 --quiet

WORKDIR ${WORKDIR}