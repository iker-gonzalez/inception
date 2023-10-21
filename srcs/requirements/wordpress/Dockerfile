# Use the 'debian:buster' base image
FROM debian:buster

# Install PHP, PHP-FPM, required PHP extensions, and php-mysql
RUN apt-get update && apt-get -y install \
    mariadb-client \
    curl \
    php \
    php-cgi \
    php-mysql \
    php-fpm \
    php-pdo \
    php-gd \
    php-cli \
    php-mbstring \
    && rm -rf /var/lib/apt/lists/*

# Install WP CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN php wp-cli.phar --allow-root
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Create the necessary user and group
RUN adduser -S -D -H -u 1000 nginx \
    && addgroup -S -g 1000 nginx

# Create the /var/www/html directory
RUN mkdir -p /var/www/html

#Copy the necessary tools to download wordpress
COPY ./config/www.conf /var/www/html/

# Create the folder to enable php start
RUN mkdir /run/php

COPY ./tools/set_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/set_wordpress.sh

WORKDIR /var/www/html/

ENTRYPOINT ["/usr/local/bin/set_wordpress.sh"]


# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm7.3", "--nodaemonize"]