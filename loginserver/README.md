# Login Server

### Build
```
docker build . -t loginserver

docker buildx build --platform linux/arm64,linux/amd64 --tag <registry>/loginserver --push .
```

### Run
```
docker run -d --cap-add NET_ADMIN -p "9000:9000/tcp" -p "9001:9001/tcp" -p "9080:9080/tcp" loginserver
```

#### Docker Compose
```
version: '3.6'

services:
  loginserver:
    image: loginserver
    container_name: loginserver
    volumes:
     - './loginserver:/data'
    ports:
     - 9000:9000
     - 9001:9001
     - 9080:9080
    cap_add:
     - NET_ADMIN
    restart: unless-stopped
```

### Generate auth code for user verification
```
$ docker exec loginserver python3 taserver/getauthcode.py <user> <email>
```
