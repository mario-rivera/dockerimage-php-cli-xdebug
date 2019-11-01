FROM php:7.3.11-cli-stretch

ENV WORKDIR /code

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
libzip-dev \
libssl-dev \
zip \
unzip \
libpq-dev \
librabbitmq-dev \
&& rm -rf /var/lib/apt/lists/*

# install php extensions
RUN docker-php-ext-configure zip --with-libzip \
&& docker-php-ext-configure pdo_pgsql \
&& docker-php-ext-install \
zip pdo pdo_pgsql bcmath sockets \
&& pecl install xdebug-2.7.2 amqp-1.9.4 \
&& docker-php-ext-enable xdebug amqp

WORKDIR ${WORKDIR}