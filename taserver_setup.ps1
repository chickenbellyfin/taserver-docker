param (
    [string] $branch = "master",
    [string] $serverconfig_template
)

function log {
    param (
        [string] $message
    )
    Write-Output ("{0} - {1}" -f (Get-Date), $message)
}

log "Starting"

$install_dir = "C:\taserver_deploy"
$data_root = "C:\taserver_data"

New-Item -path $install_dir -type directory -force

# Assumes the following files are already in the current dir
# Tribes.zip
# dependencies.zip

log "Fetching taserver-deploy from branch $branch"

curl.exe -L -o taserver-deploy.zip "https://github.com/chickenbellyfin/taserver-deploy/archive/refs/heads/$branch.zip"

log "Extracting Tribes.zip"
tar -xf Tribes.zip -C $install_dir

log "Extracting dependencies.zip"
tar -xf dependencies.zip -C $install_dir

log "Extracting taserver-deploy.zip"
tar -xf taserver-deploy.zip -C $install_dir --strip-components=1

# Install .NET 3.5
log "Installing .NET 3.5"
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All /Quiet

cd $install_dir

# We need to use `Start-Process ... -Wait` to make sure powershell does not continue before installers finish
# tribes dependencies
log "Running dxsetup.exe"
Start-Process Tribes\Binaries\Redist\directx_Jun2010_redist\DXSETUP.exe /silent -Wait

log "Running vc_redist.86.exe"
Start-Process dependencies\vc_redist.x86.exe "/install","/passive","/norestart" -Wait

# udpproxy dependency
log "Running vc_redist.x64.exe"
Start-Process dependencies\vc_redist.x64.exe "/install","/passive","/norestart" -Wait

# download latest taserver
log "Fetching latest taserver"
.\scripts\get_latest_taserver.ps1 $install_dir ".\dependencies\python\python.exe"

# setup data_root
Copy-Item ".\taserver\data" -Destination $data_root -Recurse
# copy launcher config
Copy-Item "config\gameserverlauncher.ini" -Destination "$data_root\gameserverlauncher.ini"

log "serverconfig template is \"$serverconfig_template\""
if ($serverconfig_template -ne "") {
    # create ta server game config
    log "Preparing template \"$serverconfig_template\""
    .\dependencies\python\python.exe scripts\prepare_serverconfig.py generate $serverconfig_template
    Copy-Item "serverconfig.lua" -Destination "$data_root\gamesettings\ootb\serverconfig.lua"
}

log "Setting up taserver service"
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
log "Removing Windows Defender"
Uninstall-WindowsFeature -Name Windows-Defender
log "Rebooting"
Restart-Computer