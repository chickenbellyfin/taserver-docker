#!/bin/bash
# DO NOT RUN
# This script installs taserver during docker build
set -ex

TASERVER_RELEASE_TAG="0.0.40" 

# Get taserver
if [ ! -f taserver.zip ]; then
  wget -q -O taserver.zip "https://github.com/chickenbellyfin/taserver/archive/refs/tags/$TASERVER_RELEASE_TAG.zip"
  unzip -q taserver.zip
  mv "taserver-$TASERVER_RELEASE_TAG" "taserver"
else
  unzip -q taserver.zip
fi
