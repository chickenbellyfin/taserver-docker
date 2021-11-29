#!/bin/bash
# DO NOT RUN
# This script starts taserver inside docker
set -ex

# initialize gamesettings dir
# This should be mounted by the user with -v $SOME_DIR:/gamesettings
# If not, it will use the default serverconfig
mkdir -p "/gamesettings"
if [ ! -f "/gamesettings/serverconfig.lua" ]
then
    cp -r taserver/data/gamesettings/ootb/* /gamesettings/
    chmod a+rw /gamesettings/*
fi

# TribesAscend.exe won't start without a display
pkill Xvfb || true
rm -f /tmp/.X1-lock
# Optional
# Set the framebuffer size. Seems to save ~40MB of memory
# it will also work with just `Xvfb :1 &> xvfb.out &`
Xvfb :1 -screen 0 640x480x8 &> xvfb.out &
export DISPLAY=":1"

cd taserver
# Start firewall
python3 start_taserver_firewall.py $@ &
# Start taserver
python3 start_game_server_launcher.py $@
