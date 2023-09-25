#!/bin/bash

# Start mysql service
/etc/init.d/mysql start 

# Wait for it to fully start
sleep 10

# Debugging: Print the SQL queries being executed
set -x

# Create database without double quotes for variable
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE $MYSQL_DATABASE"

# Create user with proper SQL syntax 
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"

# Grant privileges 
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON *.* TO '$MYSQL_USER'@'%';"  

# Flush privileges
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

# Debugging: Disable debugging output
set +x
