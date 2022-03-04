# Command Examples

## Edit local gamesettings
Make a directory. There should be a file called serverconfig.lua at the top level.
```
$ mkdir MyGameSettings

# should look like
$ ls MyGameSettings
LICENSE  README.md  gotylike  serverconfig.lua
```

You can now edit your settings local and copy them to the server to update.

### Get ssh key and DNS name
- figure out your where your ssh private key is `path/to/key.pem`
- figure out your VM's DNS name or IP address. In Azure, click on the VM and copy the **DNS Name**

### Copy lua gamesettings folder to server
```
rsync -vr -e "ssh -i ~/path/to/key.pem" MyGameSettings/ azureuser@my-taserver.centralus.cloudapp.azure.com:gamesettings/
```

### Restart game server
```
ssh -i ~/path/to/key.pem azureuser@my-taserver.centralus.cloudapp.azure.com ./taserver.sh -d gamesettings
```
