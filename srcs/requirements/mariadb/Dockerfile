# Use the 'debian:buster' base image
FROM debian:buster

# Update package lists
RUN apt-get update

# Install MariaDB
RUN apt-get install -y mariadb-server

# Create the target directory for volumes where database data is stored
RUN mkdir -p /var/lib/mysql

# Expose MariaDB port
EXPOSE 3306

#Command to launch mariadb and enable the database to listen globally

CMD ["mysqld", "--bind-address=0.0.0.0"]

