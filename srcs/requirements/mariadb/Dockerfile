# Use the official Debian Buster image as the base
FROM debian:buster

# Install required packages
RUN apt-get update && apt-get install -y mariadb-server

# Copy initialization script
COPY /tools/init_db.sh /docker-entrypoint-initdb.d/

# Run initialization script on startup
ENTRYPOINT ["/docker-entrypoint-initdb.d/init_db.sh"]

# Expose the MariaDB port
EXPOSE 3306 

# Start MariaDB when the container launches
CMD ["mysqld"]
