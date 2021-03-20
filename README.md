# taserver-deploy
Cloud deployment templates for [taserver](https://github.com/Griffon26/taserver)

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fchickenbellyfin%2Ftaserver-deploy%2Fmaster%2Fazure%2Fazuredeploy.json)

## Releasing
Run `release.ps1`. This will output the following files which should all be uploaded separately as part of the release:
`release/taserver_deploy.zip`

`release/taserver_setup.ps1`



## Dependencies
The server setup script requires several 3rd-party dependencies which are not part of this repository. The Azure template already points to hosted versions of these packages. 

See [Preparing Resources](preparing_resources.md) which details how to assemble those resources if they need to be updated, or hosted elsewhere. 

