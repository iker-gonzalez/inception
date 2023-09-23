# Use the 'debian:buster' base image
FROM debian:buster

# Install MariaDB
RUN apt-get update && apt-get install -y mariadb-server

# Create the target directory for volumes where database and website data is stored if it does not exist 
RUN mkdir -p /home/login/data

# Expose MariaDB port
EXPOSE 3306

# Start MariaDB when the container is run
CMD ["/usr/sbin/mysqld"]
