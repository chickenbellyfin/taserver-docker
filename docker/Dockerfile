
FROM ubuntu:20.04 as build
WORKDIR /app
RUN apt-get update && apt-get install -y python3 wget unzip

RUN wget -q "https://f000.backblazeb2.com/file/taserver-deploy-packages/Tribes.zip" && unzip -q Tribes.zip && rm Tribes.zip
RUN ln Tribes/Binaries/Win32/TribesAscend.exe Tribes/Binaries/Win32/TribesAscend1.exe
RUN ln Tribes/Binaries/Win32/TribesAscend.exe Tribes/Binaries/Win32/TribesAscend2.exe

COPY install_taserver.sh install_taserver.sh
RUN ./install_taserver.sh
COPY gameserverlauncher_docker.ini /app/taserver/data/gameserverlauncher.ini

FROM ubuntu:20.04
WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update && apt-get install --no-install-recommends -y \
  python3 \
  python3-pip \
  xvfb
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y \
  wine \
  winetricks

ENV WINEARCH=win32
ENV WINEPREFIX=/app/.wine

COPY install_ta_deps.sh install_ta_deps.sh
RUN ./install_ta_deps.sh

RUN pip install gevent

COPY --from=build /app/Tribes /app/Tribes
COPY --from=build /app/taserver /app/taserver
COPY run_taserver.sh .
ENTRYPOINT ["./run_taserver.sh"]
