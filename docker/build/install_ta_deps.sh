#!/bin/bash
# DO NOT RUN
# This script installs visual c++ and .NET during docker build
set -ex

Xvfb :1 &
export DISPLAY=":1"
winetricks -q vcrun2017 dotnet45

# Optional
# Run ngen now so that it doesn't have to run randomly in the container
# https://github.com/Winetricks/winetricks/issues/480
wine $WINEPREFIX/drive_c/windows/Microsoft.NET/Framework/v4.0.30319/ngen.exe update /force || true

pkill Xvfb

# Optional
# Remove winedevice.exe and plugplay.exe. They use a significant amount of CPU and memory (~30MB & ~10MB)
# Doesn't seem to break anything
rm $WINEPREFIX/drive_c/windows/system32/winedevice.exe
rm $WINEPREFIX/drive_c/windows/system32/plugplay.exe

