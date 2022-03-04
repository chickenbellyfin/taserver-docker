# Command Examples

## Edit local gamesettings
Make a directory. There should be a file called serverconfig.lua at the top level.
```
$ mkdir MyGameSettings

# should look like
$ ls MyGameSettings
LICENSE  README.md  gotylike  serverconfig.lua
```

### Copy lua gamesettings folder to server
```
rsync -vr -e "ssh -i ~/path/to/key.pem" MyGameSettings/ azureuser@my-taserver.centralus.cloudapp.azure.com:gamesettings/
```

### Restart game server
```
ssh -i ~/path/to/key.pem azureuser@my-taserver.centralus.cloudapp.azure.com ./taserver.sh -d gamesettings
```
