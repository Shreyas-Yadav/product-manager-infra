#!/bin/bash
# Run once on a fresh EC2 Ubuntu 22.04 instance
set -e

sudo apt update && sudo apt upgrade -y
sudo apt install -y docker.io docker-compose-plugin awscli curl git certbot

sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu


git clone https://github.com/Shreyas-Yadav/product-manager-cms.git ~/product-manager-cms
