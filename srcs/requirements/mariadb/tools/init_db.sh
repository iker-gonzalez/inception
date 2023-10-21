#!/bin/bash

# Debugging: Print the SQL queries being executed
set -x

# Set the password for the root user
mysqladmin -u root password "$MYSQL_ROOT_PASSWORD"

# Modify the MySQL configuration file to enable password authentication
sed -i '/^\[mysqld\]$/a skip-grant-tables=0' /etc/mysql/mariadb.cnf

# Start MySQL server
/etc/init.d/mysql start

# Wait for it to fully start
sleep 5

# Create database, users, and privileges
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ADMIN_USER'@'%';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_STANDARD_USER'@'%' IDENTIFIED BY '$MYSQL_STANDARD_PASSWORD';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_STANDARD_USER'@'%';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES"

# Debugging: Disable debugging output
set +x

# Properly stop MySQL server
/etc/init.d/mysql stop

exec "$@"
