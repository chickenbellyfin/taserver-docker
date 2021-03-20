# taserver-deploy
Cloud deployment templates for [taserver](https://github.com/Griffon26/taserver)

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fchickenbellyfin%2Ftaserver-deploy%2Fmaster%2Fazure%2Fazuredeploy.json)

## Managing a running taserver

This template installs taserver as a windows service, named `taserver`.
taserver will start automatically when your VM boots up. If the server crashes, the service will try to automatically restart it.

You can also restart the VM to attempt to recover a crashed server.

Server logs are located in `C:\taserver_deploy\taserver\data\logs`

### Changing Server Settings
The taserver directory will be located at `C:\taserver_deploy\taserver`, and you can edit game settings in `C:\taserver_deploy\taserver\data\gamesettings\ootb\serverconfig.lua`.

Refer to [taserver](https://github.com/Griffon26/taserver) and [TAMods-Server Docs](https://www.tamods.org/docs/doc_srv_api_overview.html) for details on configuration.

To apply settings changes, restart your VM.


## Dependencies
The server setup script requires several 3rd-party dependencies which are not part of this repository. The Azure template already points to hosted versions of these packages. 

See [Preparing Resources](preparing_resources.md) which details how to assemble those resources if they need to be updated, or hosted elsewhere. 

