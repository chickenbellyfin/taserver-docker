################################################################################
### taserver
FROM python:3 as tribes
WORKDIR /app
RUN apt-get update && apt-get install -y wget unzip

# Download & configure taserver

# For taserver development, uncomment this line and run
# zip -r taserver.zip ../../taserver to create taserver.zip
# COPY taserver.zip taserver.zip

COPY install_taserver.sh install_taserver.sh
RUN ./install_taserver.sh
COPY shared.ini /app/taserver/data/shared.ini

################################################################################
### output
FROM python:3-slim
WORKDIR /app

# disable any interactive prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Install iptables for firewall
RUN apt-get update && apt-get install --no-install-recommends -y iptables

# required by taserver
RUN pip install --no-cache-dir gevent certifi prometheus_client

# Get taserver from previous stage
COPY --from=tribes /app/taserver /app/taserver

COPY run_loginserver.sh .
ENTRYPOINT ["./run_loginserver.sh"]
EXPOSE 9000/tcp 9001/udp 9080/tcp
