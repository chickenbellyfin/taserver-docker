$PYTHON = "dependencies\python\pythonw.exe"
$TASERVER = "taserver"

$firewall = Start-Process $PYTHON `
    -ArgumentList "start_taserver_firewall.py" `
    -WorkingDirectory $TASERVER `
    -PassThru

# Wait for firewall to come up
Start-Sleep -Seconds 5

$taserver = Start-Process $PYTHON `
    -ArgumentList "start_game_server_launcher.py" `
    -WorkingDirectory $TASERVER `
    -PassThru

Wait-Process $taserver.id
