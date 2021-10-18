#!/bin/bash
set -ex
TASERVER_RELEASE_TAG="wine-v0.0.2"
TASERVER_DEPLOY_BRANCH="ubuntu"

sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y wine winetricks xvfb
export WINEARCH=win32
# some windows programs expect a display
Xvfb :1 &
export DISPLAY=":1"
winetricks -q vcrun2017 dotnet45

# get TribesAscend
wget "https://f000.backblazeb2.com/file/taserver-deploy-packages/Tribes.zip"
unzip -q Tribes.zip && rm Tribes.zip
ln Tribes/Binaries/Win32/TribesAscend.exe Tribes/Binaries/Win32/TribesAscend7777.exe
ln Tribes/Binaries/Win32/TribesAscend.exe Tribes/Binaries/Win32/TribesAscend7778.exe
TA_PATH="$(pwd)/Tribes/Binaries/Win32"

# taserver deps
sudo apt install -y python3 python3-pip
pip install gevent

# get taserver
wget -O taserver.zip "https://github.com/chickenbellyfin/taserver/archive/refs/tags/$TASERVER_RELEASE_TAG.zip"
unzip -q taserver.zip && rm taserver.zip
mv "taserver-$TASERVER_RELEASE_TAG" "taserver"

# get taserver-deploy
wget -O taserver-deploy.zip "https://github.com/chickenbellyfin/taserver-deploy/archive/refs/heads/$TASERVER_DEPLOY_BRANCH.zip"
unzip -q taserver-deploy.zip && rm taserver-deploy.zip
mv "taserver-deploy-$TASERVER_DEPLOY_BRANCH" "taserver-deploy"

# setup taserver
pushd taserver
python3 download_compatible_controller.py
python3 download_injector.py

# configure gameserverlauncher
cp ../taserver-deploy/config/gameserverlauncher_ubuntu.ini data/gameserverlauncher.ini
sed -i "s@{{TA_PATH}}@${TA_PATH}@g" data/gameserverlauncher.ini
popd

# Install service
sudo cp taserver-deploy/config/taserver.service /etc/systemd/system
sudo sed -i "s/{{INSTALL_PATH}}/$(pwd)/g"
sudo sed -i "s/{{USER}}/${USER}/g" /etc/systemd/system/taserver.service
sudo systemctl enable taserver
sudo systemctl start taserver