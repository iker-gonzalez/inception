#!/bin/sh


#Download wordpress
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
rm -rf latest.tar.gz

# Move the new file to the destination, overwriting any existing file
mv -f ./www.conf /etc/php/7.3/fpm/pool.d/www.conf

#Inport env variables in the config file
cd /var/www/html/wordpress
sed -i "s/username_here/$MYSQL_STANDARD_USER/g" wp-config-sample.php
sed -i "s/password_here/$MYSQL_STANDARD_PASSWORD/g" wp-config-sample.php
sed -i "s/localhost/$WORDPRESS_DB_HOST/g" wp-config-sample.php
sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
mv wp-config-sample.php wp-config.php

exec "$@"