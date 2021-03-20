$serverconfig_settings = $args[0]

$INSTALL_DIR = "C:\taserver_deploy"

New-Item -path "C:\logs" -type directory -force
New-Item -path $INSTALL_DIR -type directory -force

# Assumes the follwing files are already in the current dir
# Tribes.zip
# dependencies.zip
# taserver-deploy.zip

# Download the latest release of Griffon26/taserver
curl "https://api.github.com/repos/Griffon26/taserver/releases/latest" |
    ForEach-Object { ConvertFrom-Json $_.Content } | 
    ForEach-Object { curl -o taserver.zip $_.zipball_url }
New-Item -path $INSTALL_DIR\taserver -type directory -force
tar -xvf taserver.zip -C $INSTALL_DIR\taserver --strip-components=1

tar -xvf Tribes.zip -C $INSTALL_DIR
tar -xvf dependencies.zip -C $INSTALL_DIR
tar -xvf taserver-deploy.zip -C $INSTALL_DIR

# Install .NET 3.5
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All 

cd $INSTALL_DIR

# We need to use `Start-Process ... -Wait` to make sure powershell does not continue before installers finish
# tribes dependencies
Start-Process Tribes\Binaries\Redist\directx_Jun2010_redist\DXSETUP.exe /silent -Wait
Start-Process dependencies\vc_redist.x86.exe "/install","/passive","/norestart" -Wait
# udpproxy dependency
Start-Process dependencies\vc_redist.x64.exe "/install","/passive","/norestart" -Wait

# taserver - download tamods dll & udpproxy
.\dependencies\python\python.exe .\taserver\download_compatible_controller.py
.\dependencies\python\python.exe .\taserver\download_udpproxy.py

# copy launcher config
Copy-Item "config\gameserverlauncher.ini" -Destination "taserver\data\gameserverlauncher.ini"

# create ta server game config
.\dependencies\python\python.exe scripts\prepare_serverconfig.py generate $serverconfig_settings
Copy-Item "serverconfig.lua" -Destination "taserver\data\gamesettings\ootb\serverconfig.lua"

# Install taserver as a windows service and start it
cd $INSTALL_DIR\dependencies
.\nssm.exe install taserver powershell.exe
.\nssm.exe set taserver AppDirectory $INSTALL_DIR
.\nssm.exe set taserver AppParameters $INSTALL_DIR\scripts\taserver_run.ps1
.\nssm.exe set taserver DisplayName "TAServer"
.\nssm.exe set taserver Start SERVICE_AUTO_START

# skip this since we are rebooting
#.\nssm.exe start taserver

# Remove Defender (CPU hog) and restart
Uninstall-WindowsFeature -Name Windows-Defender
Restart-Computer