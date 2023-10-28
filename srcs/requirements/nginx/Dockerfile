# Use the 'debian:buster' base image
FROM debian:bullseye

# Install Nginx and OpenSSL
RUN apt-get update && apt-get install -y nginx openssl

# SSL
RUN mkdir /etc/nginx/ssl && chmod 700 /etc/nginx/ssl 
RUN openssl req -newkey rsa:4096 -sha256 -x509 -nodes -days 365 \
    -subj "/C=ES/O=42/L=Madrid/CN=Inception" \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt;

# Copy your Nginx configuration file (e.g., nginx.conf) into the container
COPY conf/nginx.conf /etc/nginx/conf.d

# Expose HTTPS port (443)
EXPOSE 443

# Start Nginx when the container is run
CMD ["nginx", "-g", "daemon off;"]
