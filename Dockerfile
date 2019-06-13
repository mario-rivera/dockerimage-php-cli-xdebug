FROM php:7.3-cli

# install php extensions
RUN pecl install xdebug-2.7.2 \
&& docker-php-ext-enable xdebug