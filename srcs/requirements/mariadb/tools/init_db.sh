#!/bin/bash

# Start mysql service
/etc/init.d/mysql start

# Wait for it to start up
sleep 5

# Create database 
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE $MYSQL_DATABASE;"

# Create user 
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL ON *.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

# Flush privileges
mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"