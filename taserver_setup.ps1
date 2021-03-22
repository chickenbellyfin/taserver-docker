param (
    [string] $branch = "master",
    [string] $serverconfig_template
)

$install_dir = "C:\taserver_deploy"
$data_root = "C:\taserver_data"

New-Item -path $install_dir -type directory -force

# Assumes the following files are already in the current dir
# Tribes.zip
# dependencies.zip

curl.exe -L -o taserver-deploy.zip "https://github.com/chickenbellyfin/taserver-deploy/archive/refs/heads/$branch.zip"

tar -xvf Tribes.zip -C $install_dir
tar -xvf dependencies.zip -C $install_dir
tar -xvf taserver-deploy.zip -C $install_dir --strip-components=1

# Install .NET 3.5
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All 

cd $install_dir

# We need to use `Start-Process ... -Wait` to make sure powershell does not continue before installers finish
# tribes dependencies
Start-Process Tribes\Binaries\Redist\directx_Jun2010_redist\DXSETUP.exe /silent -Wait
Start-Process dependencies\vc_redist.x86.exe "/install","/passive","/norestart" -Wait
# udpproxy dependency
Start-Process dependencies\vc_redist.x64.exe "/install","/passive","/norestart" -Wait

# download latest taserver
.\scripts\get_latest_taserver.ps1 $install_dir ".\dependencies\python\python.exe"

# setup data_root
Copy-Item ".\taserver\data" -Destination $data_root -Recurse
# copy launcher config
Copy-Item "config\gameserverlauncher.ini" -Destination "$data_root\gameserverlauncher.ini"

if ($serverconfig_template -ne "") {
    # create ta server game config
    .\dependencies\python\python.exe scripts\prepare_serverconfig.py generate $serverconfig_template
    Copy-Item "serverconfig.lua" -Destination "$data_root\gamesettings\ootb\serverconfig.lua"
}


# Install taserver as a windows service and start it
cd $install_dir\dependencies
.\nssm.exe install taserver powershell.exe
.\nssm.exe set taserver AppDirectory $install_dir
.\nssm.exe set taserver AppParameters $install_dir\scripts\run_taserver.ps1
.\nssm.exe set taserver DisplayName "TAServer"
.\nssm.exe set taserver AppThrottle 30000
.\nssm.exe set taserver AppExit Default Restart
.\nssm.exe set taserver AppRestartDelay 30000
.\nssm.exe set taserver Start SERVICE_AUTO_START

# skip this since we are rebooting
#.\nssm.exe start taserver

# Remove Defender (CPU hog) and restart
Uninstall-WindowsFeature -Name Windows-Defender
Restart-Computer