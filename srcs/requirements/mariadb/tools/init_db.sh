#!/bin/bash

# Start mysql service
/etc/init.d/mysql start

# Wait for it to fully start
sleep 5

# Debugging: Print the SQL queries being executed
set -x

# Create database
mysql -u root -p"$MYSQL_ADMIN_PASSWORD" -e "CREATE DATABASE $MYSQL_DATABASE"

# Create a non-standard administrator user
mysql -u root -p"$MYSQL_ADMIN_PASSWORD" -e "CREATE USER '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';"

# Grant administrative privileges
mysql -u root -p"$MYSQL_ADMIN_PASSWORD" -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ADMIN_USER'@'%';"

# Create a regular user
mysql -u root -p"$MYSQL_ADMIN_PASSWORD" -e "CREATE USER '$MYSQL_STANDARD_USER'@'%' IDENTIFIED BY '$MYSQL_STANDARD_PASSWORD';"

# Grant privileges to the regular user
mysql -u root -p"$MYSQL_ADMIN_PASSWORD" -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_STANDARD_USER'@'%';"

# Flush privileges
mysql -u root -p"$MYSQL_ADMIN_PASSWORD" -e "FLUSH PRIVILEGES;"

# Debugging: Disable debugging output
set +x

/etc/init.d/mysql stop

exec "$@"
