#!/bin/bash

############################################################
# Install Docker and enable it as a service
############################################################
sudo dnf install -y dnf-utils zip unzip
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf remove -y runc
sudo dnf install -y docker-ce --nobest
sudo systemctl enable docker.service
sudo systemctl start docker.service

############################################################
# Install Docker Compose plugin as root
# That's because docker-commands require root privileges
############################################################
sudo su -
mkdir -p ~/.docker/cli-plugins
sudo curl -L "https://github.com/docker/compose-cli/releases/download/v2.0.0-beta.6/docker-compose-$(uname -s)-arm64" -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
logout

git clone https://github.com/lynx-chess/Lynx_BOT
cd Lynx_BOT

# sudo docker buildx build --platform linux/arm64 --tag eduherminio/lynx-docker --no-cache .
sudo docker compose up --build
