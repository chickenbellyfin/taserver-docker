#!/bin/bash
# DO NOT RUN
# This script installs taserver during docker build
set -ex

TASERVER_RELEASE_TAG="v2.8.0" 

# Get taserver
if [ ! -f taserver.zip ]; then
  wget -q -O taserver.zip "https://github.com/Griffon26/taserver/archive/refs/tags/$TASERVER_RELEASE_TAG.zip"
  unzip -q taserver.zip
  mv "$(ls | grep taserver-*)" "taserver" 
else
  unzip -q taserver.zip
fi
