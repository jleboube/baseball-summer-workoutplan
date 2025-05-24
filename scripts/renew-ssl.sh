#!/bin/bash

# Renew Let's Encrypt certificates
# Run this script monthly via cron

set -e

echo "🔄 Renewing SSL certificates..."

# Renew certificates
docker compose exec certbot certbot renew --quiet

# Check if certificates were renewed
if docker compose exec certbot certbot certificates | grep -q "VALID"; then
    echo "📋 Certificates are up to date"
else
    echo "🔄 Certificates renewed, restarting nginx..."
    docker compose restart workout-calendar
fi

echo "✅ SSL certificate renewal complete"
