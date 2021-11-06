$python = "dependencies\python\pythonw.exe"
$data_root = "C:\taserver_data"

# check for TAMods update
windows\get_latest_taserver.ps1 . $python
& $python taserver\download_compatible_controller.py

$firewall = Start-Process $python `
    -ArgumentList "start_taserver_firewall.py --data-root=$data_root" `
    -WorkingDirectory taserver `
    -PassThru

# Wait for firewall to come up
Start-Sleep -Seconds 5

$taserver = Start-Process $python `
    -ArgumentList "start_game_server_launcher.py --data-root=$data_root" `
    -WorkingDirectory taserver `
    -PassThru

Wait-Process $taserver.id
