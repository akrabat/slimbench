FROM php:7.1-apache

RUN a2enmod rewrite

RUN docker-php-ext-install opcache

COPY ./ /var/www
