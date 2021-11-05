#!/bin/bash
# DO NOT RUN
# This script installs visual c++ and .NET during docker build
set -ex
Xvfb :1 &
export DISPLAY=":1"
winetricks -q vcrun2017 dotnet45
pkill Xvfb