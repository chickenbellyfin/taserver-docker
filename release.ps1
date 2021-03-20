$ErrorActionPreference = "Stop"
Remove-Item ".\release\" -Force -Recurse -ErrorAction Ignore
New-Item -path "release" -type directory -Force
Copy-Item "taserver_setup.ps1" -Destination "release\taserver_setup.ps1"
Copy-Item azure\azuredeploy.json -Destination "release\azuredeploy.json"
Compress-Archive -Path ".\config\",".\serverconfig_templates\",".\scripts\" -DestinationPath ".\release\taserver-deploy.zip"