################################################################################
### Tribes & taserver
FROM ubuntu:20.04 as tribes
WORKDIR /app
RUN apt-get update && apt-get install -y python3 python3-pip wget zstd unzip
RUN pip install certifi

# Download Tribes Ascend game files
RUN wget -q "https://f000.backblazeb2.com/file/taserver-deploy-packages/Tribes.tar.zst" && \
  tar -I zstd -xf Tribes.tar.zst && \
  rm Tribes.tar.zst

# Install community maps
COPY build/setup_custom_maps.sh setup_custom_maps.sh
RUN  ./setup_custom_maps.sh

# Download & configure taserver
COPY build/install_taserver.sh install_taserver.sh
RUN ./install_taserver.sh
COPY build/gameserverlauncher.ini /app/taserver/data/gameserverlauncher.ini
COPY build/shared.ini /app/taserver/data/shared.ini



################################################################################
### Wine & final output
FROM ubuntu:20.04
WORKDIR /app

# disable any interactive prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Install python & xvfb
RUN \
  apt-get update && \
  apt-get install --no-install-recommends -y python3 python3-pip xvfb iptables && \
  rm -rf /var/lib/apt/lists/*

# Install 32-bit wine
RUN \
  dpkg --add-architecture i386 && \
  apt-get update && \
  apt-get install -y wine winetricks && \
  rm -rf /var/lib/apt/lists/*

ENV WINEARCH=win32
ENV WINEPREFIX=/app/.wine

# Install vc++2017 and .NET 4.5 in wine
COPY build/install_ta_deps.sh install_ta_deps.sh
RUN ./install_ta_deps.sh && rm install_ta_deps.sh
# required by taserver
RUN pip install gevent certifi

# Get Tribes and taserver from previous stage
COPY --from=tribes /app/Tribes /app/Tribes
COPY --from=tribes /app/taserver /app/taserver

COPY build/run_taserver.sh .
ENTRYPOINT ["./run_taserver.sh"]
EXPOSE 7777/tcp 7777/udp 7778/tcp 7778/udp 9002/tcp
