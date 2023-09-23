# Use the 'debian:buster' base image
FROM debian:buster

# Install Nginx and OpenSSL
RUN apt-get update && apt-get install -y nginx openssl

# Generate a self-signed SSL certificate (for testing purposes)
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/server.key -out /etc/nginx/server.crt -subj "/C=US/ST=CA/L=San Francisco/O=My Company/OU=DevOps/CN=localhost"

# Copy your Nginx configuration file (e.g., nginx.conf) into the container
COPY conf/default.conf /etc/nginx/nginx.conf

# Expose HTTPS port (443)
EXPOSE 443

# Start Nginx when the container is run
CMD ["nginx", "-g", "daemon off;"]
