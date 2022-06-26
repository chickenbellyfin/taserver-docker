# taserver-deploy
Cloud deployment templates for [taserver](https://github.com/Griffon26/taserver)

## Build
```
docker build . -t taserver
```

## Run
```
docker run \
  --name "taserver" -d --cap-add NET_ADMIN \
  -v "$(pwd)/gamesettings:/gamesettings" -p "9002:9002/tcp" \
  -p "7777:7777/tcp" -p "7777:7777/udp" \
  -p "7778:7778/tcp" -p "7778:7778/udp" \
  taserver
```

### Helper Script
This project includes a helper script which will run the above command:
```
./taserver.sh -d gamesettings
```

### Ports
You must open the following ports in your security group and/or firewall:
- 7777-7778 TCP **and** UDP
- 9002 TCP

## Configuration
The gameserver settings will be located in the directory that is mounted to `/gamesettings` (`-v <path>:/gamesettings` if you ran docker and `-d <path>` if you used `taserver.sh`).

To use pre-existing serverconfigs, create the directory and copy your `serverconfig.lua` into it, as well as any other lua files it depends on (like `admin.lua`).

- If you start a server without a gamesettings dir, it will start with the default settings from [taserver](https://github.com/Griffon26/taserver/tree/master/data/gamesettings/ootb) and appear as _"My Custom OOTB Server"_.

- If you start a server and the directory does not exist, it will be created and the default `serverconfig.lua` will be copied into it. You can edit that file and restart the server to make changes.

Refer to [TAMods-Server Docs](https://www.tamods.org/docs/doc_srv_api_overview.html) for details on configuration.


## Running Multiple Servers

### Ports
If you want to run multiple taservers from your host machine, you must open more ports, depending on how many servers you want to host.

For each range starting at 7777 and at 9002, open **N * 2** ports counting up

ex. For 5 servers, add 10:
- 7777-7787 TCP & UDP
- 9002-9010 TCP

For the 9002- range, only the even ports are used. You may choose to only open the exact ports: 9002,9004,9006,... for extra security.

### Running Additional Servers
The wrapper script makes it easy to run multiple taserver instances.

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

## Restart a Server
Restarting a server is useful to pick up new config changes or fix some unknown problem.
```
docker restart taserver

# taserver.sh: containers are named taserver_$CONFIGDIR_$PORTOFFSET
$ docker restart taserver_my_server_0
```

## Kill a Running Server
```
$ docker kill taserver
```
You can start the server again by re-running the same command (or the script)

## Deploy To Azure
Installs docker and loads the taserver docker image from this project on an Ubuntu VM.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fchickenbellyfin%2Ftaserver-deploy%2Fmaster%2Fazuredeploy.json)

For details about instances sizes and resources required, see [Resources](docs/resources.md)

## Testing & Development

See [Testing & Development](docs/development.md)
