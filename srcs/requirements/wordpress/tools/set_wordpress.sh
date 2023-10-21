#!/bin/sh

echo "Check Wordpress environment variables:"
echo "DOMAIN_NAME: $DOMAIN_NAME"
echo "MYSQL_HOSTNAME: $MYSQL_HOSTNAME"
echo "WP_TITLE: $WP_TITLE"
echo "WP_ADMIN_USER: $WP_ADMIN_USER"
echo "WP_ADMIN_PASSWORD: $WP_ADMIN_PASSWORD"
echo "WP_ADMIN_EMAIL: $WP_ADMIN_EMAIL"
echo "WP_USER: $WP_USER"
echo "WP_USER_PASSWORD: $WP_USER_PASSWORD"
echo "WP_USER_EMAIL: $WP_USER_EMAIL"

echo "Check MariaDB environment variables:"
echo "MYSQL_HOSTNAME: $MYSQL_HOSTNAME"
echo "MYSQL_DATABASE: $MYSQL_DATABASE"
echo "MYSQL_STANDARD_USER: $MYSQL_STANDARD_USER"
echo "MYSQL_STANDARD_PASSWORD: $MYSQL_STANDARD_PASSWORD"

if [ -f wp-config.php ]
then
	echo "wordpress already downloaded"
else

    #Download wordpress
    wp cli update

    echo "[i] Downloading Wordpress"
    wp core download --allow-root

    # Move the new file to the destination, overwriting any existing file
    mv -f ./www.conf /etc/php/7.3/fpm/pool.d/www.conf

    # Create wp-config.php file
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_STANDARD_USER --dbpass=$MYSQL_STANDARD_PASSWORD --dbhost=$MYSQL_HOSTNAME --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root

    # Install WordPress CLI and create users
    echo "    url=$DOMAIN_NAME/wordpress"
    echo "    title=$WP_TITLE"
    echo "    admin_user=$WP_ADMIN_USR"
    echo "    admin_password=$WP_ADMIN_PWD"
    echo "    admin_email=$WP_ADMIN_EMAIL"
    wp core install --url=$DOMAIN_NAME/wordpress --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=author --user_pass=$WP_USER_PASSWORD --allow-root


fi

exec "$@"