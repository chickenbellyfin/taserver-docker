# Ubuntu (deprecated)
Installs taserver directly on a host machine running Ubuntu. 

**It is not recommended to run this install script on your personal computer**

_Tested with Ubuntu 20.04_


### Deploy to Azure

This ARM template will deploy this project as a Linux VM in azure. The network security group (firewall) will be pre-configured. 
The full deployment takes about 10 minutes and the server should appear in the community server browser soon afterwards.

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fchickenbellyfin%2Ftaserver-deploy%2Fmaster%2Fazure%2Fazuredeploy_ubuntu.json)


### Deploy to AWS / Other Providers

You can also deploy cloud providers such as AWS by creating your own Ubuntu EC2 or other VPS instance, and running the commands below:

```
cd ~  # Optional, script will work outside of home dir too

wget https://raw.githubusercontent.com/chickenbellyfin/taserver-deploy/ubuntu/taserver_setup_ubuntu.sh
chmod +x taserver_setup_ubuntu.sh
./taserver_setup_ubuntu.sh

```

#### Ports (All OSes)
You must also need to open the following ports in your security group and/or firewall:
- TCP 7777-7778
- UDP 7777-7778
- TCP 9002


### Server Management

taserver is installed as a systemd service, and can be managed with `sudo systemctl [start|stop|restart|status] taserver`. The service will start on boot and restart on failure.

#### Edit Game Settings
Server settings are located in `~/taserver/data`.

Refer to [taserver](https://github.com/Griffon26/taserver) and [TAMods-Server Docs](https://www.tamods.org/docs/doc_srv_api_overview.html) for details on configuration.


#### Restart taserver
```
$ sudo systemctl restart taserver
```

#### Stop taserver
```
# taserver will stop until the next reboot
$ sudo systemctl stop taserver

# taserver will be disabled and not start after a reboot
$ sudo systemctl start taserver
```

#### Start taserver
```
# taserver will run until the next reboot
$ sudo systemctl start taserver

# taserver will be started on every reboot
$ sudo systemctl start taserver
```


#### Install Dodge's Custom Maps
To install [Dodge's Custom Maps](https://www.dodgesdomain.com/docs/custommaps/trctf-blues), run the following script on the server:
```
cd ~
./taserver-deploy/scripts/setup_custom_maps.sh

# Restart taserver to pick up the changes
sudo systemctl restart taserver
```
Make sure to add the maps to your serverconfig.lua


## Dependencies
The setup script download the Tribes Ascend game files, which are not in this repository. The Azure template & install script already points to a hosted copy of Tribes.zip

See [Preparing Resources](preparing_resources.md) which details how to assemble Tribes.zip.
