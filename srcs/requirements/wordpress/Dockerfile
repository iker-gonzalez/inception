# Use the 'debian:buster' base image
FROM debian:buster

# Install PHP, PHP-FPM, required PHP extensions, and php-mysql
RUN apt-get update && apt-get -y install \
    wget \
    php \
    php-cgi \
    php-mysql \
    php-fpm \
    php-pdo \
    php-gd \
    php-cli \
    php-mbstring \
    && rm -rf /var/lib/apt/lists/*

# Create the /var/www/html directory
RUN mkdir -p /var/www/html

# Install WordPress
RUN wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xzvf /tmp/wordpress.tar.gz -C /var/www/html/ && \
    rm /tmp/wordpress.tar.gz

# Update PHP-FPM config file
COPY ./config/www.conf /etc/php/7.3/fpm/pool.d/

# Create the folder to enable php start
RUN mkdir /run/php

WORKDIR /var/www/html/

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm7.3", "--nodaemonize"]
