#!/bin/bash
set -ex

dockeruser=${1:-$USER}

# Install docker
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
curl -L "https://get.docker.com" -o "get-docker.sh"
sudo sh get-docker.sh && rm get-docker.sh

# setup current user for docker
sudo usermod -aG docker $dockeruser

# get taserver image
docker pull public.ecr.aws/i2q9d4v7/taserver:latest
docker tag public.ecr.aws/i2q9d4v7/taserver:latest taserver

# download helper script
wget -O taserver.sh "https://raw.githubusercontent.com/chickenbellyfin/taserver-deploy/docker/master/docker/taserver.sh"
chmod +x taserver.sh
./taserver.sh -d gamesettings
