#!/bin/bash
set -e

DOMAIN=$1
EMAIL=$2

if [ -z "$DOMAIN" ] || [ -z "$EMAIL" ]; then
  echo "Usage: ./setup-ssl.sh <domain> <email>"
  exit 1
fi

# Stop frontend container to free port 80 for certbot standalone mode
cd ~/product-manager-cms
docker compose -f docker-compose.prod.yml stop frontend 2>/dev/null || true

# Obtain Let's Encrypt certificate
sudo certbot certonly --standalone \
  -d "$DOMAIN" \
  --email "$EMAIL" \
  --agree-tos \
  --non-interactive

# Substitute YOUR_DOMAIN placeholder in nginx.prod.conf
sed -i "s/YOUR_DOMAIN/$DOMAIN/g" ~/product-manager-cms/frontend/nginx.prod.conf

echo ""
echo "SSL certificate obtained for $DOMAIN"
echo "Certs are at: /etc/letsencrypt/live/$DOMAIN/"
echo ""
echo "Now start the app:"
echo "  cd ~/product-manager-cms"
echo "  docker compose -f docker-compose.prod.yml up -d"
