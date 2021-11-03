#!/bin/bash
set -ex
Xvfb :1 &
export DISPLAY=":1"
winetricks -q vcrun2017 dotnet45
pkill Xvfb