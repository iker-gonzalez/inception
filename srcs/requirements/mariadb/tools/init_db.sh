#!/bin/bash

# Start MySQL server
/etc/init.d/mysql start

# Wait for it to fully start
sleep 5

# # Debugging: Print the SQL queries being executed
set -x

# Set root option so that connexion without root password is not possible

mysql_secure_installation <<_EOF_

Y
${MYSQL_ROOT_PASSWORD}
${MYSQL_ROOT_PASSWORD}
Y
n
Y
Y
_EOF_

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
