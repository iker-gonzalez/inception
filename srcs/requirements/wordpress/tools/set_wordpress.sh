#!/bin/sh

if [ -f wp-config.php ]
then
	echo "wordpress already downloaded"
else

    #Download wordpress
    wget https://wordpress.org/latest.tar.gz
    tar -xzvf latest.tar.gz
    rm -rf latest.tar.gz

    # Move the new file to the destination, overwriting any existing file
    mv -f ./www.conf /etc/php/7.3/fpm/pool.d/www.conf

    # Import environment variables into wp-config.php
    cd /var/www/html/wordpress
    sed -i "s/username_here/$MYSQL_STANDARD_USER/g" wp-config-sample.php
    sed -i "s/password_here/$MYSQL_STANDARD_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
    sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php

    # Rename wp-config-sample.php to wp-config.php
    mv wp-config-sample.php wp-config.php

    # Install WordPress CLI and create users
    wp core install --url=$DOMAIN_NAME --title=Inception --admin_user=$WP_ADMIN_USER --admin_password=WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
    wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=author


fi

exec "$@"