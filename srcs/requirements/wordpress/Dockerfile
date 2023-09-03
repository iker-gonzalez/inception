# Use the 'debian:buster' base image
FROM debian:buster

# Install PHP and required extensions
RUN apt-get update && apt-get install -y php php-mysql

# Install WordPress
# You can use 'curl' or 'wget' to download and extract WordPress

# Expose a port if your PHP application uses one

# Start your PHP application (e.g., Apache or PHP-FPM) when the container is run
CMD ["php-fpm"]
