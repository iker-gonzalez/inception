# Use the 'debian:buster' base image
FROM debian:buster

# Install MariaDB
RUN apt-get update && apt-get install -y mariadb-server

# Expose MariaDB port
EXPOSE 3306

# Start MariaDB when the container is run
CMD ["mysqld"]
