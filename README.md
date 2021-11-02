# taserver-deploy
Cloud deployment templates for [taserver](https://github.com/Griffon26/taserver)


### Deploy to Azure (Ubuntu)
[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fchickenbellyfin%2Ftaserver-deploy%2Fubuntu%2Fazure%2Fazuredeploy_ubuntu.json)

Server configs are located in `~/taserver/data/`

taserver is installed as a systemd service, and can be managed with `sudo systemctl [start|stop|restart|status] taserver`. The service will start on boot and restart on failure.

#### Install Dodge's Custom Maps
To install [Dodge's Custom Maps](https://www.dodgesdomain.com/docs/custommaps/trctf-blues), run the following script after installing taserver:
```
cd ~
./taserver-deploy/scripts/setup_custom_maps.sh

# Restart taserver to pickup the changes
sudo systemctl restart taserver
```


### Deploy To Azure (Windows Server)
[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fchickenbellyfin%2Ftaserver-deploy%2Fmaster%2Fazure%2Fazuredeploy.json)

### Deploy to AWS / Other Providers
You can still deploy cloud providers other than Azure by creating your own EC2 or other VPS instance, and running one of the commands below:

#### Ubuntu
```
wget https://raw.githubusercontent.com/chickenbellyfin/taserver-deploy/ubuntu/taserver_setup_ubuntu.sh
chmod +x taserver_setup_ubuntu.sh
./taserver_setup_ubuntu.sh

```

#### Windows
```
> curl.exe -o taserver_setup.ps1 https://raw.githubusercontent.com/chickenbellyfin/taserver-deploy/master/taserver_setup.ps1
>  .\taserver_setup.ps1
```

#### Ports (All OSes)
You will also need to open the following ports in your security group:
- TCP 7777-7778
- UDP 7777-7778
- TCP 9002

Refer to [taserver](https://github.com/Griffon26/taserver) documentation for further details.

## Managing a running taserver (windows)

This template installs taserver as a windows service, named `taserver`.
taserver will start automatically when your VM boots up. If the server crashes, the service will try to automatically restart it.

You can also restart the VM to attempt to recover a crashed server.

Server logs are located in `C:\taserver_data\logs`

### Changing Server Settings (windows)
The taserver directory will be located at `C:\taserver_deploy\taserver`, and you can edit game settings in `C:\taserver_data\gamesettings\ootb\serverconfig.lua`.

Refer to [taserver](https://github.com/Griffon26/taserver) and [TAMods-Server Docs](https://www.tamods.org/docs/doc_srv_api_overview.html) for details on configuration.

To apply settings changes, restart your VM.


## Dependencies
The server setup script requires several 3rd-party dependencies which are not part of this repository. The Azure template already points to hosted versions of these packages. 

See [Preparing Resources](preparing_resources.md) which details how to assemble those resources if they need to be updated, or hosted elsewhere. 

