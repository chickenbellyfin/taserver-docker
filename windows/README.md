# Windows
Installs taserver on a host machine running Windows.

**It is not recommended to run this install script on your personal computer**

_Tested with Windows Server 2019 on Azure & AWS_


### Deploy To Azure 
This ARM template will deploy this project as a Windows VM in azure. The network security group (firewall) will be pre-configured. 

This template also provides presets for various game types, server name, password, and admin password.

The full deployment takes about 10 minutes and the server should appear in the community server browser soon afterwards.
[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fchickenbellyfin%2Ftaserver-deploy%2Fmaster%2Fazure%2Fazuredeploy.json)

### Deploy to AWS / Other Providers

You can also deploy cloud providers such as AWS by creating your own Windows EC2 or other VPS instance, and running the commands below in **powershell**:

```
> curl.exe -o taserver_setup.ps1 https://raw.githubusercontent.com/chickenbellyfin/taserver-deploy/master/taserver_setup.ps1
>  .\taserver_setup.ps1
```

#### Ports
You must also need to open the following ports in your security group / VM firewall:
- TCP 7777-7778
- UDP 7777-7778
- TCP 9002

### Server Management

taserver is installed as a windows service, named `taserver`. 

taserver will start automatically when your VM boots up. If the server crashes, the service will try to automatically restart it.

#### Edit Game Settings
Server settings are located in `C:\taserver_data\`.

Refer to [taserver](https://github.com/Griffon26/taserver) and [TAMods-Server Docs](https://www.tamods.org/docs/doc_srv_api_overview.html) for details on configuration.


#### Restart taserver
powershell:
```
> C:\taserver_deploy\windows\restart_taserver.ps1
```

#### Stop taserver
powershell
```
sc.exe stop taserver
```

#### Start taserver
powershell
```
> sc.exe start taserver
```

## Dependencies
The server setup script requires several 3rd-party dependencies which are not part of this repository. The Azure template/install script already points to hosted versions of these packages. 

See [Preparing Resources](preparing_resources.md) which details how to assemble those resources if they need to be updated, or hosted elsewhere. 
