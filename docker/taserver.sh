#!/bin/bash
# This script makes it easy to start new taserver docker containers
# taserver docker image should be loaded in docker already
# Usage: start_taserver_container.sh -d gamesettings_dir -p port_offset
# port offset should differ by at least 2 between all containers
set -eux

mount_gamesettings=""
portoffset="0"
pathname=""
detach_option="-d --restart unless-stopped"

while getopts d:p:f flag
do
  case "$flag" in
    d) 
      abspath=$(realpath ${OPTARG})
      pathname="_$(basename $abspath)" # used for container name
      # create server config dir if it does not exist
      mkdir -p $abspath
      # docker flag to mount config dir to /gamesettings in the container
      mount_gamesettings="-v ${abspath}:/gamesettings"
      ;;
    p)
      portoffset="${OPTARG}"
      ;;
    f)
      # if run in foreground, cleanup on stop
      detach_option="--rm"
      ;;
  esac
done

let "control_port = 9002 + $portoffset"
let "gameserver1_port = 7777 + $portoffset"
let "gameserver2_port = 7778 + $portoffset"

container_name="taserver${pathname}_${portoffset}"
# Container Naming
#    (no args)                 => taserver_0
#    -d /path/to/myconfig      => taserver_myconfig_0
#    -d /path/to/myconfig -p 2 => taserver_myconfig_2

# attempt to remove existing
docker rm -f "$container_name" || true

# TODO: investigate `--network host` instead of port mappings
docker run \
  --name "$container_name" \
  $detach_option \
  $mount_gamesettings \
  --cap-add NET_ADMIN \
  -p "$control_port:$control_port/tcp" \
  -p "$gameserver1_port:$gameserver1_port/tcp" \
  -p "$gameserver1_port:$gameserver1_port/udp" \
  -p "$gameserver2_port:$gameserver2_port/tcp" \
  -p "$gameserver2_port:$gameserver2_port/udp" \
  taserver --port-offset="$portoffset"
