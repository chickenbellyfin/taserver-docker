# taserver
[taserver](https://github.com/Griffon26/taserver) is a community-built replacement for the Tribes Ascend login server. 
This image runs a Tribes Ascend game server (using taserver's game server launcher) which is accessible through a community login server.

The git repository for this image is [chickenbellyfin/taserver-docker](https://github.com/chickenbellyfin/taserver-docker)

## Tags and Image Variants

### `taserver:latest`
The latest release of [taserver](https://github.com/Griffon26/taserver) with the base game.

### `taserver:latest-maps`
The latest release of [taserver](https://github.com/Griffon26/taserver) + a collection of community-made maps. More info on the community maps can be found at [Dodge's Domain](https://www.dodgesdomain.com/docs/).

### `taserver:<version>` and `taserver:<version>-maps`
Images built with specific versions of taserver. It is high recommended to use `:latest`/`:latest-maps` instead.

## How to Run

This command will start a server called "My Custom OOTB Server", which will be available on the default community loginserver at `ta.kfk4ever.com`.

```
docker run \
  --name "taserver" -d --cap-add NET_ADMIN \
  -v "$(pwd)/gamesettings:/gamesettings" \
  -p "7777:7777/tcp" -p "7777:7777/udp" \
  -p "7778:7778/tcp" -p "7778:7778/udp" \
  -p "9002:9002/tcp" -p "9002:9002/udp" \
  chickenbellyfin/taserver
```

### Ports
You must open the following ports in your security group and/or firewall:

- 7777-7778 TCP and UDP
- 9002 TCP **and** UDP

### Helper script
There is a helper script in the git repo for this project which will make it easier to launch a game server.

```
# Download helper script and make it executable
curl -o taserver.sh https://raw.githubusercontent.com/chickenbellyfin/taserver-docker/master/taserver.sh
chmod +x taserver.sh

# Start a gameserver
# This is equivalent to the docker run command above
./taserver.sh -d gamesettings
```
Servers launched using this script will keep running, even through crashes and reboots. This is useful if you are setting up a 24/7 server. 

### Docker Compose
```
services:
  taserver:
    image: chickenbellyfin/taserver
    container_name: taserver
    volumes:
      - './gamesettings:/gamesettings'
    ports:
      - '9002:9002/udp'
      - '9002:9002/tcp'
      - '7777:7777/udp'
      - '7777:7777/tcp'
      - '7778:7778/udp'
      - '7778:7778/tcp'
    restart: unless-stopped
    cap_add:
     - NET_ADMIN
```

## Editing Server Settings
On the first run, the default game server lua config will be copied (only if it doesn't already exist) to `./gamesettings`, or whichever directory you mounted to `/gamesettings` in the run command. You can edit the `serverconfig.lua` and re-start the container to apply the new settings.

Refer to [tamods.org](https://www.tamods.org/docs/server/doc_srv_api_overview) for how to edit lua gamesettings and available options.

### Adding community maps to the rotation

To add the community-made maps to the map rotation, add the following to `serverconfig.lua`. Players must have the maps installed via [TAMods](tamods.org) to play.
```
ServerSettings.MapRotation.addCustom("TrCTF-Blues")
ServerSettings.MapRotation.addCustom("TrCTF-Incidamus")
ServerSettings.MapRotation.addCustom("TrCTF-Periculo")
ServerSettings.MapRotation.addCustom("TrCTF-Fracture")
ServerSettings.MapRotation.addCustom("TrCTF-Phlegethon")
ServerSettings.MapRotation.addCustom("TrCTF-DesertedValley")
ServerSettings.MapRotation.addCustom("TrCTF-Acheron")
ServerSettings.MapRotation.addCustom("TrCTF-Styx")
ServerSettings.MapRotation.addCustom("TrCTFBlitz-Broadside")
ServerSettings.MapRotation.addCustom("TrArena-ElysianBattleground")
```

## Running Multiple Servers

### Ports
If you want to run multiple taservers from your host machine, you must open more ports, depending on how many servers you want to host.

For each range starting at 7777 and at 9002, open **N * 2** ports counting up

ex. For 5 servers, add 10:
- 7777-7787 TCP & UDP
- 9002-9010 TCP & UDP

For the 9002- range, only the even ports are used. You may choose to only open the exact ports: 9002,9004,9006,... for extra security.

### Running Additional Servers
The [helper script](https://github.com/chickenbellyfin/taserver-docker/blob/master/taserver.sh) makes it easy to run multiple taserver instances.

For more than one server, you must also add `-p <port_offset>`, where port_offset must be a multiple of 2.

```
# start a taserver with port offset 0, game config will be in ./my_server/serverconfig.lua
$ ./taserver.sh -d my_server

# start a second server with a different config located in ./maybe_arena/
$ ./taserver.sh -d maybe_arena -p 2

# Start a third server, identical to the first
# we can re-use the config directory
$ ./taserver -d my_server -p 4

# start 10 identical servers
$ for i in {0..10}; do ./start_taserver.sh -d arena_settings -p $((i*2)) ; done
```

## Resources
In general, reserve 1GB of RAM for each server you want to run, 1 CPU core for each server which can be active (with players in it) at any given time. 

For example, on a 2 core, 8GB RAM system, you can have 8 servers available, and 2 of them can have an ongoing game without causing issues.

[Details on resources](https://github.com/chickenbellyfin/taserver-docker/blob/master/docs/resources.md)
