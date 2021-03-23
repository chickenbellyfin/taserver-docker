param (
    [parameter(mandatory)][string] $install_dir,
    [parameter(mandatory)][string] $python
)

# Download the latest release of Griffon26/taserver
$json = curl.exe -s "https://api.github.com/repos/chickenbellyfin/taserver/releases/latest"
$latest =  ConvertFrom-Json "$json"
$tag_name = $latest.tag_name
$zip_url = $latest.zipball_url

if ($tag_name -eq "") {
    Write-Output "Failed to get tag name. Exiting."
    exit
}

# get previously stored taserver version
$current_tag_name = Get-Content -Path taserver_version.txt

if ($current_tag_name -ne $tag_name) {
    Write-Output "Downloading taserver $tag_name from $zip_url"

    curl.exe -s -L -o taserver.zip $zip_url
    New-Item -path $install_dir\taserver -type directory -force
    tar -xf taserver.zip -C $install_dir\taserver --strip-components=1
    
    # save new version
    Write-Output "$tag_name" | Out-File -FilePath taserver_version.txt
    
    # download udpproxy.exe
    & $python $install_dir\taserver\download_udpproxy.py
} else {
    Write-Output "Current version $current_tag_name is already latest"
}

