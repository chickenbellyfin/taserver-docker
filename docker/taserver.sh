#!/bin/bash
# This script makes it easy to start new taserver docker containers
# taserver docker image should be loaded in docker already
# Usage: start_taserver_container.sh -d gamesettings_dir -p port_offset
# port offset should differ by at least 2 between all containers
set -ex

mount_gamesettings=""
portoffset="0"
pathname=""
detach="-d"

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
      # option to not detach
      detach=""
      ;;
  esac
done

let "control_port = 9002 + $portoffset"
let "gameserver1_port = 7777 + $portoffset"
let "gameserver2_port = 7778 + $portoffset"

# Container Naming
#    (no args)                 => taserver_0
#    -d /path/to/myconfig      => taserver_myconfig_0
#    -d /path/to/myconfig -p 2 => taserver_myconfig_2

# TODO: investigate `--network host` instead of port mappings
docker run \
  --name "taserver${pathname}_${portoffset}" $detach --rm \
  $mount_gamesettings \
  -p "$control_port:$control_port/tcp" \
  -p "$gameserver1_port:$gameserver1_port/tcp" \
  -p "$gameserver1_port:$gameserver1_port/udp" \
  -p "$gameserver2_port:$gameserver2_port/tcp" \
  -p "$gameserver2_port:$gameserver2_port/udp" \
  taserver --port-offset="$portoffset"
