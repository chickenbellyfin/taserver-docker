#!/bin/bash
# DO NOT RUN
# This script installs Tribes and taserver during docker build
set -ex

if [ -z "$TASERVER_RELEASE_TAG" ];
then
  TASERVER_RELEASE_TAG="$(curl https://api.github.com/repos/Griffon26/taserver/releases/latest | jq -r '.tag_name')"
fi

# get taserver
if [ ! -f taserver.zip ]; then
  wget -q -O taserver.zip "https://github.com/Griffon26/taserver/archive/refs/tags/$TASERVER_RELEASE_TAG.zip"
  unzip -q taserver.zip
  mv $(ls | grep taserver-*) "taserver"
else
  unzip -q taserver.zip
fi

cd taserver

python3 download_compatible_controller.py
python3 download_injector.py
