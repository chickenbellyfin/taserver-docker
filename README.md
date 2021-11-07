# taserver-deploy
Cloud deployment templates for [taserver](https://github.com/Griffon26/taserver)

## WIP: Docker-based install on Ubuntu
Installs docker and loads the taserver docker image from this project on an Ubuntu host.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fchickenbellyfin%2Ftaserver-deploy%2Fdocker%2Fdocker%2Fazuredeploy.json)

Create an Ubuntu VM on Azure/AWS/etc, and run the following commands:
```
wget https://raw.githubusercontent.com/chickenbellyfin/taserver-deploy/ubuntu/taserver_setup_ubuntu_docker.sh
chmod +x taserver_setup_ubuntu_docker.sh
./taserver_setup_ubuntu_docker.sh
```

_TODO: instructions for other distros_

#### VM Size / Resources
**TL;DR: 1 CPU / 2GB RAM is enough for 1 full server**

A CPU in this case refers to a single core. taserver will use 15-70% CPU and 500MB-1GB RAM based on how full it is. If you would like to run multiple servers on a host, you will need more resources. 

Rule of thumb:
- add 1 CPU based on how many servers can be **active** (players in them) at any given time.
- add 1.5GB RAM based on how many total servers you want to make available.

So for example (using common vm sizes):
- 2 active servers and 6-7 total, server should be around 2CPU/8GB
- 8 total servers, all active (like in a tournament) would probably work on 8CPU/16GB 


Disk: The image is only ~6GB, and very little data gets stored, so a small disk is fine.

### Ports
You must open the following ports in your security group and/or firewall:
- 7777-7778 TCP **and** UDP
- 9002 TCP

#### Multiple Servers
If you want to run multiple taservers from your host machine, you must open more ports, depending on how many servers you want to host.

For each range starting at 7777 and at 9002, open **N * 2** ports counting up

ex. For 5 servers, add 10:
- 7777-7787 TCP & UDP
- 9002-9010 TCP

For the 9002- range, only the even ports are used. You may choose to only open the exact ports: 9002,9004,9006,... for extra security.

## Server Management
The docker image uses a mounted directory to read server settings. You can manage your settings outside of docker and run multiple different (or identical) servers at the same time.

To use pre-existing serverconfigs, create a directory and copy your `serverconfig.lua` into it, as well as any other lua files it depends on (like `admin.lua`).

Refer to [TAMods-Server Docs](https://www.tamods.org/docs/doc_srv_api_overview.html) for details on configuration.

### Start a Server (or multiple)
The wrapper script makes it easy to run one or more taserver instances.

For more than one server, you must also add `-p <port_offset>`, where port_offset must be a multiple of 2.

```
# start a taserver with port offset 0, game config will be in ./my_server/serverconfig.lua
$ ./start_taserver.sh -d my_server

# start a second server with a different config located in ./maybe_arena/
$ ./start_taserver.sh -d maybe_arena -p 2

# Start a third server, identical to the first
# we can re-use the config directory
$ ./start_taserver -d my_server -p 4

# start 10 identical servers
$ for i in {0..10}; do ./start_taserver.sh -d arena_settings -p $((i*2)) ; done
```

- If you start a server without specifying the `-d` flag, it will start with the default settings from [taserver](https://github.com/Griffon26/taserver/tree/master/data/gamesettings/ootb) and appear as "My Custom OOTB Server".

- If you start a server with `-d` and the directory does not exist, it will be created and the default `serverconfig.lua` will be copied into it. You can edit that file and restart the server to make changes.
 
### Restart a Server
Restarting a server is useful to pick up new config changes or fix some unknown problem.
```
# containers are named taserver_$CONFIGDIR_$PORTOFFSET
$ docker restart taserver_my_server_0

# if you want to see a list of running containers
$ docker ps --format "{{.Names}}"
```

### Start a Previously Killed Server
If a previously running server died and you want to re-start it, run command you used to start it again:
```
# Start the my_server server again using the existing config
$ ./start_taserver.sh -d my_server
```

### Kill a Running Server
```
$ docker kill taserver_my_server_0
```
# Other Deployment Methods:
### Deploy To Azure (Windows Server)
[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https://raw.githubusercontent.com/chickenbellyfin/taserver-deploy/docker/windows/azuredeploy.json)

See [Windows README](/windows/README.md) for details.


### DEPRECATED: Non-docker Deploy to Azure (Ubuntu)
This method of deploying taserver is being deprecated in favor of the docker-based tools.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fchickenbellyfin%2Ftaserver-deploy%2Fdocker%2Fubuntu%2Fazuredeploy.json)

See [Ubuntu README](/ubuntu/README.md) for details.
