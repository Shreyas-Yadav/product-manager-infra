#!/bin/bash
# Run once on a fresh EC2 instance (Ubuntu 22.04 or 24.04)
set -e

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y ca-certificates curl unzip git certbot


sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu

# Install AWS CLI v2 (official installer — works on all Ubuntu versions)
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
unzip /tmp/awscliv2.zip -d /tmp
sudo /tmp/aws/install
rm -rf /tmp/awscliv2.zip /tmp/aws

# Clone source repo
git clone https://github.com/Shreyas-Yadav/product-manager-cms.git ~/product-manager-cms

echo ""
echo "Bootstrap complete."
echo "Log out and back in for docker group to take effect."
echo "Then verify with: docker ps && aws --version"
