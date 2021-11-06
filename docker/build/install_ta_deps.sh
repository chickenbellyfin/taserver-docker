#!/bin/bash
# DO NOT RUN
# This script installs visual c++ and .NET during docker build
set -ex
Xvfb :1 &
export DISPLAY=":1"
winetricks -q vcrun2017 dotnet45

# Run ngen now so that it doesn't have to run randomly in the container
# https://github.com/Winetricks/winetricks/issues/480
wine $WINEPREFIX/drive_c/windows/Microsoft.NET/Framework/v4.0.30319/ngen.exe update /force || true
pkill Xvfb
