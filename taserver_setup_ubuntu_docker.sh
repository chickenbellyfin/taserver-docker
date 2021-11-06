#!/bin/bash
set -ex

dockeruser=${1:-$USER}

# Install docker
wget -O containerd.deb "https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/containerd.io_1.4.9-1_amd64.deb"
wget -O docker-cli.deb "https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce-cli_20.10.9~3-0~ubuntu-focal_amd64.deb"
wget -O docker-ce.deb "https://download.docker.com/linux/ubuntu/dists/focal/pool/stable/amd64/docker-ce_20.10.9~3-0~ubuntu-focal_amd64.deb"

sudo dpkg -i containerd.deb
sudo dpkg -i docker-cli.deb
sudo dpkg -i docker-ce.deb

rm *.deb

# setup current user for docker
sudo usermod -aG docker $dockeruser
newgrp docker

# get taserver image
docker pull public.ecr.aws/i2q9d4v7/taserver:latest
docker tag public.ecr.aws/i2q9d4v7/taserver:latest taserver

# download helper script
wget -O start_taserver.sh "https://raw.githubusercontent.com/chickenbellyfin/taserver-deploy/docker/docker/start_taserver.sh"
chmod +x start_taserver.sh
./start_taserver.sh -d gamesettings