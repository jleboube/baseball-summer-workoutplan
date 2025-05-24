#!/bin/bash

# Setup Let's Encrypt certificates for a domain
# Usage: ./setup-letsencrypt.sh your-domain.com your-email@example.com

set -e

DOMAIN=$1
EMAIL=$2

if [ -z "$DOMAIN" ] || [ -z "$EMAIL" ]; then
    echo "Usage: $0 <domain> <email>"
    echo "Example: $0 workout.mydomain.com me@example.com"
    exit 1
fi

echo "🔐 Setting up Let's Encrypt for domain: $DOMAIN"

# Create ssl directory
mkdir -p ./ssl

# Update nginx config for initial challenge
cat > nginx-challenge.conf << EOF
events {
    worker_connections 1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;
    
    server {
        listen 80;
        server_name $DOMAIN;
        
        location /.well-known/acme-challenge/ {
            root /var/www/certbot;
        }
        
        location / {
            root /usr/share/nginx/html;
            index index.html;
        }
    }
}
EOF

# Start with HTTP only for initial challenge
docker compose up -d

# Wait for container to be ready
sleep 10

# Request certificate from Let's Encrypt
echo "📋 Requesting certificate from Let's Encrypt..."
docker compose exec certbot certbot certonly \
    --webroot \
    --webroot-path=/var/www/certbot \
    --email $EMAIL \
    --agree-tos \
    --no-eff-email \
    -d $DOMAIN

# Copy certificates to the expected location
docker compose exec workout-calendar cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem /etc/nginx/ssl/
docker compose exec workout-calendar cp /etc/letsencrypt/live/$DOMAIN/privkey.pem /etc/nginx/ssl/

# Update to SSL configuration
cp nginx-ssl.conf nginx.conf

# Restart with SSL configuration
docker compose restart workout-calendar

echo "✅ Let's Encrypt SSL certificates installed successfully!"
echo "🌐 Your app is now available at: https://$DOMAIN"

# Clean up
rm nginx-challenge.conf
