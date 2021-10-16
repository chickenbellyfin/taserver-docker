#!/bin/bash
set -e

# Kill taserver if its already running
pkill --full "game_server_launcher" || true # kill tasever
pkill Xvfb || true
wineserver -k # Kill TribesAscend.exe

# TribesAscend.exe won't start without a display
nohup Xvfb :1 &> xvfb.out & 
export DISPLAY=":1"

# redirect external port to Tribes's internal TCP port
# Required for admin commands to work
if ! iptables -L  -t nat | grep "7777 redir";
    then
        echo "Adding iptables redirect 7777 -> 7677"
        iptables -t nat -A PREROUTING -p tcp --dport 7777 -j REDIRECT --to-port 7677
    else
        echo "iptables redirect 7777->7677 already exists"
fi

if ! iptables -L  -t nat | grep "7778 redir";
    then
        echo "Adding iptables redirect 7778 -> 7678"
        iptables -t nat -A PREROUTING -p tcp --dport 7778 -j REDIRECT --to-port 7678
    else
        echo "iptables redirect 7778->7678 already exists"
fi

# Start taserver
nohup python3 start_game_server_launcher.py &
