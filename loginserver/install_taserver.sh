#!/bin/bash
# DO NOT RUN
# This script installs taserver during docker build
set -ex

TASERVER_RELEASE_TAG="0.0.43"

# Get taserver
if [ ! -f taserver.zip ]; then
  wget -q -O taserver.zip "https://github.com/chickenbellyfin/taserver/archive/refs/tags/$TASERVER_RELEASE_TAG.zip"
  unzip -q taserver.zip
  mv "$(ls | grep taserver-*)" "taserver" 
else
  unzip -q taserver.zip
fi
