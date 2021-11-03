FROM ubuntu:20.04
WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive 
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y \
  python3 \
  python3-pip \
  wget \
  wine \
  winetricks \
  xvfb

ENV WINEARCH=win32
ENV WINEPREFIX=/app/.wine

COPY docker/install_ta_deps.sh install_ta_deps.sh
RUN ./install_ta_deps.sh

RUN pip install gevent

COPY Tribes.zip .
RUN unzip -q Tribes.zip && rm Tribes.zip
RUN ln Tribes/Binaries/Win32/TribesAscend.exe Tribes/Binaries/Win32/TribesAscend7777.exe
RUN ln Tribes/Binaries/Win32/TribesAscend.exe Tribes/Binaries/Win32/TribesAscend7778.exe

COPY docker/install_taserver.sh install_taserver.sh

RUN ./install_taserver.sh
COPY config/gameserverlauncher_ubuntu.ini /app/taserver/data/gameserverlauncher.ini
RUN sed -i "s@{{TA_PATH}}@/app/Tribes/Binaries/Win32@g" /app/taserver/data/gameserverlauncher.ini
COPY docker/run_taserver.sh .
EXPOSE 7777/tcp 7777/udp 7778/tcp 7778/udp 9002/tcp
CMD ["./run_taserver.sh"]