#!/bin/bash
TASERVER_RELEASE_TAG="wine-v0.0.1"
TASERVER_DEPLOY_BRANCH="ubuntu"

function log() {
  echo "$(date) ::: $1"
}

function install_wine() {
  sudo dpkg --add-architecture i386
  sudo apt update
  sudo apt install -y wine winetricks xvfb
}

function install_tribes_wine_deps() {
  log "Installing TribesAscend deps"
  export WINEARCH=win32
  # some windows programs expect a display
  Xvfb :1 &
  export DISPLAY=":1"
  winetricks -q vcrun2017 dotnet45
}

function install_tribes() {
  # get TribesAscend
  log "Downloading Tribes.zip"
  wget "https://f000.backblazeb2.com/file/taserver-deploy-packages/Tribes.zip"
  unzip -q Tribes.zip
  ln Tribes/Binaries/Win32/TribesAscend.exe Tribes/Binaries/Win32/TribesAscend7777.exe
  ln Tribes/Binaries/Win32/TribesAscend.exe Tribes/Binaries/Win32/TribesAscend7778.exe
}

function install_python() {
  log "Installing python"
  sudo apt install -y python3 python3-pip
  pip install gevent
}

function install_taserver() {
  TA_PATH="$(pwd)/Tribes/Binaries/Win32"
  # get taserver
  log "Downloading taserver & taserver-deploy"
  wget -O taserver.zip "https://github.com/chickenbellyfin/taserver/archive/refs/tags/$TASERVER_RELEASE_TAG.zip"
  unzip -q taserver.zip
  mv "taserver-$TASERVER_RELEASE_TAG" "taserver"

  # get taserver-deploy
  wget -O taserver-deploy.zip "https://github.com/chickenbellyfin/taserver-deploy/archive/refs/heads/$TASERVER_DEPLOY_BRANCH.zip"
  unzip -q taserver-deploy.zip
  mv "taserver-deploy-$TASERVER_DEPLOY_BRANCH" "taserver-deploy"

  # setup taserver
  log "Setting up taserver"
  cd taserver
  python3 download_compatible_controller.py
  python3 download_injector.py

  # configure gameserverlauncher
  cp ../taserver-deploy/config/gameserverlauncher_ubuntu.ini data/gameserverlauncher.ini
  sed -i "s@{{TA_PATH}}@${TA_PATH}@g" data/gameserverlauncher.ini
}

# Start downloading tribes and installing wine
install_tribes &
install_tribes_pid=$!

install_wine &
install_wine_pid=$!

# after wine is installed, start installing python & winetricks deps in parallel
wait $install_wine_pid

install_python &
install_python_pid=$!

install_tribes_wine_deps & # depends on wine
install_tribes_wine_deps_pid=$!

wait $install_python_pid

install_taserver & # depends on python
install_taserver_pid=$!

wait $install_tribes_pid
wait $install_tribes_wine_deps_pid
wait $install_taserver_pid

# Install service
sudo cp taserver-deploy/config/taserver.service /etc/systemd/system
sudo sed -i "s/{{USER}}/${USER}/g" /etc/systemd/system/taserver.service
sudo systemctl enable taserver
sudo systemctl start taserver