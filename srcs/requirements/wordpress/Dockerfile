# Use the 'debian:buster' base image
FROM debian:buster

# Install PHP, PHP-FPM, required PHP extensions, and php-mysql
RUN apt-get update && \
    apt-get install -y php php-fpm php-mysql wget unzip 

# Create the target directory
RUN mkdir -p /var/www

# Install WordPress
RUN wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xzvf /tmp/wordpress.tar.gz -C /var/www/ && \
    rm /tmp/wordpress.tar.gz

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm", "--nodaemonize"]
