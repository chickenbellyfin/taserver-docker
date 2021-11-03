#!/bin/bash
set -ex
TASERVER_RELEASE_TAG="wine-v0.0.2"

# get taserver
wget -q -O taserver.zip "https://github.com/chickenbellyfin/taserver/archive/refs/tags/$TASERVER_RELEASE_TAG.zip"
unzip -q taserver.zip && rm taserver.zip
mv "taserver-$TASERVER_RELEASE_TAG" "taserver"

cd taserver
python3 download_compatible_controller.py
python3 download_injector.py