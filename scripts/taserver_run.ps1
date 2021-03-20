$PYTHON = "resources\python\pythonw.exe"
$TASERVER = "taserver"
$LOGS = "C:\logs"

$firewall = Start-Process $PYTHON `
    -ArgumentList "start_taserver_firewall.py" `
    -WorkingDirectory $TASERVER `
    -RedirectStandardOut $LOGS\taserver_firewall.log `
    -RedirectStandardError $LOGS\taserver_firewall.err.log `
    -PassThru

Start-Sleep -Seconds 5

$taserver = Start-Process $PYTHON `
    -ArgumentList "start_game_server_launcher.py" `
    -WorkingDirectory $TASERVER `
    -RedirectStandardOut $LOGS\taserver.log `
    -RedirectStandardError $LOGS\taserver.err.log `
    -PassThru

Wait-Process $taserver.id

