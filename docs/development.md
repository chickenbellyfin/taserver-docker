# Testing & Development

## Test
To test:

1. Start container. `-f` runs it in the foreground
```
$ taserver.sh -f
```

2. Start tribes (game client) with `-hostx=ta.kfk4ever.com`
3. Join the server "My Custom OOTB Server". You should see some logging from the taserver process
4. Make sure that gameplay (shooting ,etc) work
5. Make sure that server commands work: `/srvlogin test test` should reply with "Login Failed"
6. `docker kill taserver_0`

## Development
By default, the Dockerfile will pull the latest taserver release from github. If you are testing changes to taserver, make the following changes:
- make a zip of your taserver dir and copy it to `taserver.zip` in this repo
- in `build/install_taserver.sh`, comment out `wget .. taserver.zip` and `mv .. taserver`
- add `COPY taserver.zip .` in the Dockerfile right before `COPY build/install_taserver.sh install_taserver.sh`

## Tribes package
The docker build downloads a copy of the Tribes Ascend game files. [Creating Tribes.tar.zst](create_tribes_archive.md) has instructions on how to create this file.
