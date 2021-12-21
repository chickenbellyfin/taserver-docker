#!/bin/bash
# DO NOT RUN
# This script starts login server inside docker
set -ex

# initialize data dir
# This should be mounted by the user with -v $SOME_DIR:/data
mkdir -p "/data"
if [ ! -f "/data/loginserver.ini" ]
then
    cp -r taserver/data/* /data/
fi

cd taserver
# Start firewall
python3 start_taserver_firewall.py --data-root=/data $@ &
# Start taserver
python3 start_login_server.py --data-root=/data $@
