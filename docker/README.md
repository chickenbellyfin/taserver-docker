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

To run directly. This is equivalent to the wrapper script above.
```
$ mkdir gamesettings
$ docker run \
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
5. Make that Server commands work: `/srvlogin test test` should reply with "Login Failed"
6. `docker kill taserver_0`

### Modifying game settings
In order to modify/save game settings, you must provide a directory as a volume as follows:
```
# settings will be saved locally in my_settings/
$ docker run -v ./my_settings:/gamesettings taserver
```

If the directory doesn't exist or there is no `serverconfig.lua` in it, it will be created and the default configs from taserver will be copied in.
