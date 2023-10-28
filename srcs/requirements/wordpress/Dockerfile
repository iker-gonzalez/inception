# Use the 'debian:buster' base image
FROM debian:bullseye

# Install PHP 8.2, PHP-FPM, required PHP extensions, and php-mysql
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
RUN adduser --system --no-create-home --disabled-password --uid 1000 nginx \
    && addgroup --system --gid 1000 nginx

# Create the /var/www/html directory
RUN mkdir -p /var/www/html

# Copy the www.conf file to the container's working directory
COPY ./config/www.conf /tmp/www.conf

# Move the new file to the destination, overwriting any existing file
RUN mv -f /tmp/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Create the folder to enable php start
RUN mkdir /run/php

COPY ./tools/set_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/set_wordpress.sh

WORKDIR /var/www/html/

ENTRYPOINT ["/usr/local/bin/set_wordpress.sh"]

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM with PHP 8.2
CMD ["php-fpm7.4", "--nodaemonize"]
