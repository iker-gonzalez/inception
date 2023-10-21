#!/bin/bash

# Debugging: Print the SQL queries being executed
set -x

# Set the password for the root user
mysqladmin -u root password $MYSQL_ROOT_PASSWORD

# Force MySQL root user to use a password
sed -i '/^\[mysqld\]$/a skip-grant-tables' /etc/mysql/mysql.conf.d/mysqld.cnf

mysql_install_db

/etc/init.d/mysql start

# Wait for it to fully start
sleep 5

# Check if the database exists

# if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
# then 

#     echo "Database already exists"
# else


    # Create database
    mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE $MYSQL_DATABASE"

    # Create a non-standard administrator user
    mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';"

    # Grant administrative privileges
    mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ADMIN_USER'@'%';"

    # Create a regular user
    mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER '$MYSQL_STANDARD_USER'@'%' IDENTIFIED BY '$MYSQL_STANDARD_PASSWORD';"

    # Grant privileges to the regular user
    mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_STANDARD_USER'@'%';"

    # Flush privileges
    mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

    # Debugging: Disable debugging output
    set +x

# fi

/etc/init.d/mysql stop

exec "$@"
