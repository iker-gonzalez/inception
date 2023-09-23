# Use the 'debian:buster' base image
FROM debian:buster

# Install PHP and required extensions, as well as other necessary packages
RUN apt-get update && \
    apt-get install -y php php-mysql wget unzip nginx supervisor

# Download and extract WordPress
RUN wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xzvf /tmp/wordpress.tar.gz -C /var/www/ && \
    rm /tmp/wordpress.tar.gz

# Configure Nginx and PHP-FPM
COPY wordpress.conf /etc/nginx/sites-available/default
COPY php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf

# Create a directory for storing WordPress uploads
RUN mkdir /var/www/wordpress/wp-content/uploads

# Set permissions for WordPress files
RUN chown -R www-data:www-data /var/www/wordpress

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Nginx and PHP-FPM using Supervisor
CMD ["/usr/bin/supervisord", "-n"]
