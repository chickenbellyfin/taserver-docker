# Docker Image
This is a docker image based on ubuntu which runs taserver using wine.

### Build
```
$ DOCKER_BUILDKIT=1 docker build . -t taserver
```

### Run

It is recommended to run using the wrapper script:
```
$ taserver.sh -d gamesettings
```

Command to run directly. This is equivalent to the wrapper script above.
```
$ mkdir gamesettings
$ docker run \
    --cap-add NET_ADMIN \
    -p 7777:7777 -p 7777:7777/udp -p 7778:7778 -p 7778:7778/udp -p 9002:9002 \
    -v "$(pwd)/gamesettings":/gamesettings \
    taserver
```

### Test
To test:

- Start container. `-f` runs it in the foreground
```
$ taserver.sh -f
```

2. Start tribes (game client) with `-hostx=ta.kfk4ever.com`
3. Join the server "My Custom OOTB Server". You should see some logging from the taserver process
4. Make sure that gameplay (shooting ,etc) work
5. Make sure that server commands work: `/srvlogin test test` should reply with "Login Failed"
6. `docker kill taserver_0`

### Development
By default, the Dockerfile will pull the latest taserver release from github. If you are testing changes to taserver, make the following changes:
- make a zip of your taserver dir and copy it to `/docker/taserver.zip` in this repo
- in `/docker/build/install_taserver.sh`, comment out `wget .. taserver.zip` and `mv .. taserver`
- add `COPY taserver.zip .` in the Dockerfile right before `COPY build/install_taserver.sh install_taserver.sh`

### Modifying game settings
In order to modify/save game settings, you must provide a directory as a volume as follows:
```
# settings will be saved locally in my_settings/
$ docker run -v ./my_settings:/gamesettings taserver
```

If the directory doesn't exist or there is no `serverconfig.lua` in it, it will be created and the default configs from taserver will be copied in.
