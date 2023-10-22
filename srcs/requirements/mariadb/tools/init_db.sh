#!/bin/bash

echo "Check MariaDB environment variables:"
echo "MYSQL_ROOT_PASSWORD: $MYSQL_ROOT_PASSWORD"
echo "MYSQL_DATABASE: $MYSQL_DATABASE"
echo "MYSQL_STANDARD_USER: $MYSQL_STANDARD_USER"
echo "MYSQL_STANDARD_PASSWORD: $MYSQL_STANDARD_PASSWORD"

# Start MySQL server
/etc/init.d/mysql start

# Wait for it to fully start
sleep 2

# # Debugging: Print the SQL queries being executed
set -x

# Set root option so that connexion without root password is not possible

mysql_secure_installation <<_EOF_

Y
secret
secret
Y
n
Y
Y
_EOF_

#Add a root user on localhost to allow remote connexion
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

# Create database, users, and privileges
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_STANDARD_USER'@'%' IDENTIFIED BY '$MYSQL_STANDARD_PASSWORD';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_STANDARD_USER'@'%';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES"

# Debugging: Disable debugging output
set +x

# Properly stop MySQL server
/etc/init.d/mysql stop

exec "$@"
