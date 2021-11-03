#!/bin/bash
set -ex
TASERVER_RELEASE_TAG="wine-v0.0.4"

# get taserver
wget -q -O taserver.zip "https://github.com/chickenbellyfin/taserver/archive/refs/tags/$TASERVER_RELEASE_TAG.zip"
unzip -q taserver.zip && rm taserver.zip
mv "taserver-$TASERVER_RELEASE_TAG" "taserver"

cd taserver

# TODO: uncomment & remove wget call after merging https://github.com/mcoot/tamods-server/pull/1
#python3 download_compatible_controller.py
wget -q "https://github.com/chickenbellyfin/tamods-server/releases/download/v0.0.1/TAMods-Server.dll"

python3 download_injector.py