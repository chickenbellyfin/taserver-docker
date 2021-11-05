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
rm /tmp/.X1-lock || true
Xvfb :1 &> xvfb.out &
export DISPLAY=":1"

cd taserver
# Start taserver
python3 start_game_server_launcher.py $@
