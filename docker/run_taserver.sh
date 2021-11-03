#!/bin/bash
set -ex

# TribesAscend.exe won't start without a display
pkill Xvfb || true
rm /tmp/.X1-lock
Xvfb :1 &> xvfb.out &
export DISPLAY=":1"

cd taserver
# Start taserver
python3 start_game_server_launcher.py
