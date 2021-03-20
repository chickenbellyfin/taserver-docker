$ErrorActionPreference = "Stop"
Remove-Item ".\release\" -Force -Recurse -ErrorAction Ignore
New-Item -path "release" -type directory -Force
Copy-Item "taserver_setup.ps1" -Destination "release\taserver_setup.ps1"
Compress-Archive -Path ".\config\",".\serverconfig_templates\",".\scripts\" -DestinationPath ".\release\taserver-deploy.zip"