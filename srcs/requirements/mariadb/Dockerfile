# Use the official Debian Buster image as the base
FROM debian:bullseye

# Install required packages
RUN apt-get update && apt-get -y install mariadb-server mariadb-client \
&& rm -rf /var/lib/apt/lists/* \
# purge and re-create /var/lib/mysql with appropriate ownership
&& mkdir -p /var/run/mysqld \
&& chown -R mysql:mysql /var/run/mysqld \
# ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
&& chmod 777 /var/run/mysqld

# Copy initialization script
COPY /tools/init_db.sh /usr/local/bin/

# Run initialization script on startup
ENTRYPOINT ["/usr/local/bin/init_db.sh"]

# Expose the MariaDB port
EXPOSE 3306 

# Start MariaDB when the container launches
CMD ["mysqld", "--bind-address=0.0.0.0"]
