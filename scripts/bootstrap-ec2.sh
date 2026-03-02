#!/bin/bash
# Run once on a fresh EC2 Ubuntu 22.04 instance
set -e

sudo apt update && sudo apt upgrade -y
sudo apt install -y docker.io docker-compose-plugin awscli curl git certbot

sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu

# Clone source repo (replace with your GitHub username)
git clone https://github.com/YOUR_USERNAME/product-manager-cms.git ~/product-manager-cms

echo ""
echo "Bootstrap complete."
echo "Next steps:"
echo "  1. Log out and back in (for docker group to take effect)"
echo "  2. Run: bash ~/product-manager-cms/scripts/setup-ssl.sh <your-domain> <your-email>"
